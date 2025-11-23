---
title: "Tối ưu Docker cho Python"
author: "Hoàng Dương"
date: "2025-11-23"
draft: false
description: "Phân tích các kỹ thuật tối ưu Dockerfile từ Dockerfile Contest 2025 cho ứng dụng Python/FastAPI."
categories: ["Docker Optimization"]
tags: ["docker", "python", "fastapi", "performance"]
image: "images/docker-optimization/docker-optimization-python.webp"
license: "DevOpsVN"
---

## Dockerfile Contest 2025 – Python tối ưu extreme

Dockerfile Contest 2025 thúc đẩy cộng đồng DevOps Việt Nam đánh giá lại cách viết Dockerfile để đạt **bảo mật, tối ưu, tường minh**. Dưới đây là phần tổng hợp riêng cho hạng mục Python (ứng dụng FastAPI backend service).

---

## I. Hạng mục PYTHON (Tối ưu cho Backend Service)

Hạng mục Python tập trung vào việc tối ưu kích thước image, bảo mật (patch CVE), và hiệu năng runtime cho các ứng dụng FastAPI. Các giải pháp đa dạng từ distroless, Alpine tối giản, đến wheel-based builds.

### 1. Dockerfile TOP 1 (Python) – Thanh Nguyen The

| Kỹ thuật | Giải thích theo tác giả | Nguồn tham khảo |
| --- | --- | --- |
| **UV Package Manager** | Sử dụng `uv` thay vì pip để tăng tốc độ cài đặt dependencies và quản lý virtual environment hiệu quả hơn. |  |
| **Distroless Base Image** | Dùng `gcr.io/distroless/base-debian12:nonroot` để giảm attack surface, không có shell, package manager, hoặc các công cụ không cần thiết. |  |
| **Multi-arch Support** | Hỗ trợ cả amd64 và arm64 bằng cách copy shared libraries theo kiến trúc tương ứng. |  |
| **Shared Libraries Copy** | Copy các thư viện cần thiết (libc, libm, libz, libgcc_s) từ builder stage để ứng dụng chạy được trong distroless. |  |
| **Security Patching** | Nâng cấp starlette lên 0.49.1 để fix CVE-2025-62727 và CVE-2025-54121 mà không cần sửa pyproject.toml. |  |
| **LD_LIBRARY_PATH** | Thiết lập biến môi trường để hệ thống tìm thấy shared libraries tại thư mục tùy chỉnh. |  |

**Dockerfile TOP 1 (Python)**

```
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim@sha256:6b8ac7bb76766ffe9f6cc20f56789755d539e8d0e605d8983131227c5c8b87a1 AS builder
ENV UV_LINK_MODE=copy

ARG TARGETARCH
# Copy shared libraries đủ để chạy ứng dụng trong môi trường distroless
# Kiểm tra shared libraries cần thiết với lệnh:
# ldd $(which python3) và các thư viện khác trong virtual environment sau khi cài đặt các package cần thiết (kiểm tra trước khi build)
# Mỗi kiến trúc sẽ đặt thư viện trong các thư mục khác nhau, ví dụ: /lib/x86_64-linux-gnu/ cho amd64, /lib/aarch64-linux-gnu/ cho arm64
# do đó cần xác định kiến trúc và copy từ thư mục tương ứng. 
# TARGETARCH là built-in arg của docker buildx, tự động nhận giá trị (amd64 hoặc arm64) khi build multi-arch
# Shared libraries copy ở lệnh phía dưới là chưa đủ để chạy ứng dụng, tuy nhiên gcr.io/distroless/base-debian12 (image sử dụng làm base image cho runtime tại runtime state) đã có sẵn một số shared libraries nên chỉ cần copy những thư viện còn thiếu.
# gcr.io/distroless/base-debian12:nonroot không có shell, kiểm tra shared libraries bằng cách sử dụng gcr.io/distroless/base-debian12:debug
# gcr.io/distroless/base-debian12:debug tương tự gcr.io/distroless/base-debian12:nonroot nhưng có thêm shell để phục vụ debug.
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        LIBARCH="x86_64"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        LIBARCH="aarch64"; \
    else \
        LIBARCH="unknown"; \
    fi && \
    mkdir -p /lib/multi-arch && \
    cp /lib/${LIBARCH}-linux-gnu/libc.so.6 /lib/multi-arch/ && \
    cp /lib/${LIBARCH}-linux-gnu/libm.so.6 /lib/multi-arch/ && \
    cp /lib/${LIBARCH}-linux-gnu/libz.so.1 /lib/multi-arch/ && \
    cp /lib/${LIBARCH}-linux-gnu/libgcc_s.so.1 /lib/multi-arch/

WORKDIR /build

# Sử dụng cache để tăng tốc độ build
# Cài đặt dependencies trong uv virtual environment
# Sử dụng mount type=bind để bind các file uv.lock và pyproject.toml từ host vào container mount thay vì copy.
# --frozen để đảm bảo chỉ cài đặt đúng phiên bản dependencies trong uv.lock, không update uv.lock
# --no-install-project để không cài đặt project hiện tại (chỉ cài đặt dependencies)
# --no-dev để không cài đặt dev dependencies
# --no-editable để không cài đặt editable mode
# starlette 0.46.2 dính CVE-2025-62727 CVE-2025-54121, nâng cấp để vá lỗi bảo mật (do thay đổi pyproject.toml và file uv.lock sẽ vi phạm nội quy nên chạy lệnh install riêng)

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev --no-editable && \
    uv pip install "starlette==0.49.1" --no-deps

# Sử dụng distroless làm base image cho runtime để đảm bảo tính bảo mật và tối ưu kích thước image
# Chọn distroless thay vì alpine vì alpine sử dụng musl libc, trong khi python và nhiều thư viện phổ biến trong python được biên dịch với glibc, dẫn đến các vấn đề tương thích.
# distroless giúp ứng dụng chạy ổn định hơn và cũng rất nhẹ.
# cc-debian12 có nhiều shared libraries cần thiết cho python và các package phổ biến hơn so với base-debian12
# tuy nhiên khi đã kiểm tra kỹ các shared libraries cần thiết (với lệnh ldd) và copy đầy đủ từ builder stage thì base-debian12 sẽ giúp tối ưu kích thước image hơn mà vẫn đảm bảo ứng dụng chạy ổn định.
FROM gcr.io/distroless/base-debian12:nonroot@sha256:10136f394cbc891efa9f20974a48843f21a6b3cbde55b1778582195d6726fa85 AS runtime

LABEL maintainer="Thanh Nguyen The"
LABEL maintainer.email="thanhnt.devops@gmail.com"
LABEL maintainer.company="VIETNAM NATIONAL CYBER SECURITY TECHNOLOGY CORPORATION"
LABEL maintainer.youtube="DevOps Mentor"
LABEL image.description="Secure, minimal Python app using UV and Distroless"

WORKDIR /app

# Copy các thư viện và python từ builder stage
COPY --from=builder /lib/multi-arch/ /lib/multi-arch/
COPY --from=builder /usr/local/lib/libpython3.13.so.1.0 /usr/local/lib/libpython3.13.so.1.0
COPY --from=builder /usr/local/lib/python3.13/ /usr/local/lib/python3.13/
COPY --from=builder /usr/local/bin/python /usr/local/bin/python3
# Copy virtual environment từ builder
COPY --from=builder --chown=nonroot:nonroot /build/.venv/ /app/.venv/

# Copy source code - chỉ copy những gì cần thiết
COPY --chown=nonroot:nonroot src/ ./src/

# Thiết lập environment variables
# Do runtime limit là 1 vCPU, 512MB RAM nên thiết lập WORKERS=2 thay vì 3 (nguy cơ OOM). Công thức worker = (2 x số lượng vCPU + 1) chỉ áp dụng trong trường hợp > 1GB RAM
# LD_LIBRARY_PATH để hệ thống có thể tìm thấy các shared libraries cần thiết tại thư mục mới thay vì thư mục mặc đinh (/lib/x86_64-linux-gnu hoặc /lib/aarch64-linux-gnu)
# shared libraries không có trong /lib/multi-arch sẽ tiếp tục được load từ thư mục mặc định của hệ thống
ENV PATH="/app/.venv/bin/:$PATH" \
    PYTHONPATH="/app/src/" \
    LANG=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONHASHSEED=random \
    HOST=0.0.0.0 \
    PORT=8080 \
    WORKERS=2 \
    LOGGING__LEVEL=INFO \
    LOGGING__FORMAT=PLAIN \
    COFFEE_API__HOST="https://api.sampleapis.com/coffee/" \
    APP_VERSION=0.1.0 \
    GIT_COMMIT_SHA=sha \
    LD_LIBRARY_PATH=/lib/multi-arch

# nonroot user mặc định đã được sử dụng trong distroless base-debian12:nonroot nên không cần thiết phải thêm lệnh phía dưới
# USER nonroot:nonroot

# Expose port mặc định
EXPOSE 8080

# Command để chạy ứng dụng
ENTRYPOINT ["python", "src/python_service_template/app.py"]
```

---

### 2. Dockerfile TOP 2 (Python) – newnol

| Kỹ thuật | Giải thích theo tác giả | Nguồn tham khảo |
| --- | --- | --- |
| **Alpine Base Image** | Sử dụng `python:3.13-alpine` để có image nhỏ hơn so với Debian-based images. |  |
| **Security Patches** | Cập nhật các package có CVE: starlette, fastapi, aiohttp, pydantic, structlog, uvloop, uvicorn lên phiên bản an toàn. |  |
| **Ultra Aggressive Optimization** | Strip tất cả `.so` files, xóa `__pycache__`, test, doc, examples, typing stubs, license files để giảm kích thước. |  |
| **Python Stdlib Cleanup** | Xóa các module không cần thiết như pip, setuptools, wheel, tkinter, distutils, lib2to3, idlelib, test, unittest. |  |
| **Non-root User** | Tạo user UID 10001 với quyền tối thiểu để tăng bảo mật. |  |
| **Healthcheck** | Sử dụng wget để kiểm tra endpoint `/health/` với timeout ngắn. |  |

**Dockerfile TOP 2 (Python)**

```
# syntax=docker/dockerfile:1.7

# =============================================================================
# DOCKERFILE ULTRA OPTIMIZED + SECURITY PATCHED
# Mục tiêu: Nhẹ (<110MB) + Bảo mật cao (0 CVEs)
# =============================================================================

# -----------------------------------------------------------------------------
# Stage 1: Dependencies Builder
# -----------------------------------------------------------------------------
FROM python:3.13-alpine@sha256:e5fa639e49b85986c4481e28faa2564b45aa8021413f31026c3856e5911618b1 AS deps

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache --virtual .build-deps \
      build-base \
      python3-dev \
      cargo

# Install dependencies với PATCHED versions để fix CVEs
# Note: FastAPI 0.116+ required for starlette 0.49.1+ support
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install --no-cache-dir --prefix=/install \
         "aiohttp>=3.12.14,<4.0.0" \
         "asgi-correlation-id>=4.3.4,<5.0.0" \
         "fastapi>=0.116.0" \
         "prometheus-fastapi-instrumentator>=7.0.0,<8.0.0" \
         "pydantic>=2.11.0,<3.0.0" \
         "pydantic-settings>=2.9.1,<3.0.0" \
         "structlog>=25.3.0,<26.0.0" \
         "uvloop>=0.21.0,<0.22.0" \
         "uvicorn[standard]>=0.30.0,<0.31.0"

# ULTRA AGGRESSIVE optimization
RUN apk add --no-cache binutils \
 # Strip ALL .so files aggressively
 && find /install -type f \( -name '*.so*' -o -name '*.a' \) -exec strip --strip-all {} + 2>/dev/null || true \
 # Remove all bytecode
 && find /install \( -type d -name __pycache__ -o -type f -name '*.py[co]' \) -delete 2>/dev/null || true \
 # Remove test/doc/examples
 && find /install -type d \( -name tests -o -name testing -o -name test -o -name doc -o -name docs -o -name example -o -name examples \) -prune -exec rm -rf {} + 2>/dev/null || true \
 # Minimize .dist-info
 && find /install -name '*.dist-info' -type d -exec sh -c 'cd "$1" && find . -type f ! -name "METADATA" ! -name "top_level.txt" ! -name "RECORD" -delete' _ {} \; 2>/dev/null || true \
 # Remove typing stubs, headers, C files
 && find /install -type f \( -name '*.pyi' -o -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.cc' \) -delete \
 # Remove license files
 && find /install -type f \( -name 'LICENSE*' -o -name 'COPYING*' -o -name 'NOTICE*' -o -name 'AUTHORS*' -o -name 'CHANGELOG*' -o -name 'README*' \) -delete 2>/dev/null || true \
 && apk del binutils .build-deps

# -----------------------------------------------------------------------------
# Stage 2: Runtime (ULTRA MINIMAL + SECURE)
# -----------------------------------------------------------------------------
FROM python:3.13-alpine@sha256:e5fa639e49b85986c4481e28faa2564b45aa8021413f31026c3856e5911618b1 AS runtime

LABEL org.opencontainers.image.title="Python Service Template" \
      org.opencontainers.image.description="Production-ready FastAPI service - Optimized & Secured" \
      org.opencontainers.image.version="0.1.0" \
      org.opencontainers.image.authors="newnol <contact@newnol.io.vn>" \
      maintainer="newnol" \
      security.scan="trivy-passed"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    HOST=0.0.0.0 \
    PORT=5000 \
    WORKERS=1 \
    PYTHONPATH=/app/src \
    TZ=UTC

# Install ONLY wget for healthcheck
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache wget

WORKDIR /app

# Create non-root user
RUN addgroup -g 10001 -S app \
 && adduser -u 10001 -S -G app -h /app -s /sbin/nologin app

# Copy dependencies
COPY --from=deps --chown=app:app /install /usr/local

# Copy source (minimal)
COPY --chown=app:app src/ ./src/

# Permissions
RUN chmod -R 550 /app

# EXTREME Python stdlib cleanup
RUN rm -rf \
    /usr/local/lib/python3.13/ensurepip \
    /usr/local/lib/python3.13/site-packages/pip* \
    /usr/local/lib/python3.13/site-packages/setuptools* \
    /usr/local/lib/python3.13/site-packages/wheel* \
    /usr/local/lib/python3.13/distutils \
    /usr/local/lib/python3.13/lib2to3 \
    /usr/local/lib/python3.13/idlelib \
    /usr/local/lib/python3.13/tkinter \
    /usr/local/lib/python3.13/turtledemo \
    /usr/local/lib/python3.13/test \
    /usr/local/lib/python3.13/unittest/test \
    /usr/local/bin/pip* \
    /usr/local/bin/2to3* \
    /usr/local/bin/idle* \
    2>/dev/null || true

# Clean up more unused stdlib modules
RUN cd /usr/local/lib/python3.13 && rm -rf \
    turtle.py \
    pydoc_data \
    2>/dev/null || true

USER app

EXPOSE 5000

# Heathcheck 
HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=2 \
    CMD wget --no-verbose --tries=1 -O /dev/null http://127.0.0.1:${PORT}/health/ || exit 1

STOPSIGNAL SIGTERM

CMD ["python", "src/python_service_template/app.py"]
```

---

### 3. Dockerfile TOP (Python) – Wheel-based Build

| Kỹ thuật | Giải thích | Nguồn tham khảo |
| --- | --- | --- |
| **Wheel-based Installation** | Build tất cả dependencies thành wheel files, sau đó cài đặt offline để tăng tốc độ build và đảm bảo reproducibility. |  |
| **Dynamic Security Patching** | Sử dụng Python script để parse `pyproject.toml`, tự động nâng cấp fastapi và starlette lên phiên bản an toàn mà không cần sửa file gốc. |  |
| **PIP_ONLY_BINARY** | Chỉ sử dụng wheel files, không build từ source, giúp build nhanh hơn và tránh lỗi compilation. |  |
| **Offline Installation** | Cài đặt từ wheel files local, không cần kết nối internet ở runtime stage. |  |
| **Native Healthcheck** | Sử dụng Python `http.client` thay vì external tools như curl/wget, giảm dependencies. |  |
| **Non-root User** | Tạo user UID 10001 với home directory riêng để tăng bảo mật. |  |

**Dockerfile TOP (Python)**

```
# syntax=docker/dockerfile:1.7
#
##############################
# builder
##############################
FROM python:3.13-slim AS builder

ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_ONLY_BINARY=:all: \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Pre-cache manifests
COPY pyproject.toml README.md LICENSE* ./

# Fix HIGH vulnerable issue: CVE-2025-62727 by upgrading starlette and fastapi.
RUN --mount=type=cache,target=/root/.cache/pip python - <<'PY'
import tomllib, pathlib, re
def parse_req(s:str):
    m = re.match(r'^\s*([A-Za-z0-9_.-]+)(\[[^\]]+\])?\s*(.*)$', s)
    if m:
        name, extras, rest = m.group(1), (m.group(2) or ''), (m.group(3) or '')
        return name, extras, rest
    name = re.split(r'[><=~!; ]', s, 1)[0]
    return name, '', s[len(name):]

data = tomllib.loads(pathlib.Path('pyproject.toml').read_text())
deps = data.get('project', {}).get('dependencies', [])
safe = []
present = set()
for d in deps:
    name, extras, rest = parse_req(d)
    norm = name.lower().replace('_','-')
    if norm == 'fastapi':
        safe.append(f'fastapi{extras}>=0.118,<0.121')
    else:
        safe.append(d)
    present.add(norm)
if 'starlette' not in present:
    safe.append('starlette>=0.49.1,<0.50')
pathlib.Path('/requirements.safe.txt').write_text('\n'.join(safe) + '\n')
print('Resolved safe deps:', *safe, sep='\n- ')
PY

# Wheel ALL dependencies from the safe list
RUN --mount=type=cache,target=/root/.cache/pip \
    pip wheel --wheel-dir /wheels -r /requirements.safe.txt

# Build wheel of the project itself
COPY src/ ./src/
RUN --mount=type=cache,target=/root/.cache/pip \
    pip wheel --wheel-dir /wheels .


##############################
# runtime
##############################
FROM python:3.13-slim AS runtime

ARG VERSION=0.1.0
ARG VCS_REF=sha
ARG BUILD_DATE

LABEL org.opencontainers.image.title="python-service-template" \
      org.opencontainers.image.description="Dockerfile contest build" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.licenses="Apache-2.0"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONOPTIMIZE=2 \
    HOST=0.0.0.0 \
    PORT=5000 \
    WORKERS=1 \
    APP_VERSION=$VERSION \
    GIT_COMMIT_SHA=$VCS_REF

# Non-root
RUN useradd --create-home --uid 10001 --shell /usr/sbin/nologin appuser
WORKDIR /home/appuser

# Install offline: install ALL safe deps, then the app wheel with --no-deps
COPY --from=builder /wheels /wheels
COPY --from=builder /requirements.safe.txt /requirements.safe.txt
RUN pip install --no-index --find-links=/wheels -r /requirements.safe.txt \
    && pip install --no-index --find-links=/wheels --no-deps \
       python-service-template --no-compile \
    && rm -rf /wheels /requirements.safe.txt

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=2s --start-period=10s --retries=3 \
  CMD python -c "import sys, http.client; c=http.client.HTTPConnection('127.0.0.1', int(__import__('os').environ.get('PORT','5000')), timeout=1); c.request('GET','/health'); r=c.getresponse(); sys.exit(0 if r.status==200 else 1)" || exit 1

USER 10001:10001

CMD ["python", "-m", "python_service_template.app"]
```

---

### 4. Dockerfile TOP (Python) – Khiem Doan

| Kỹ thuật | Giải thích | Nguồn tham khảo |
| --- | --- | --- |
| **UV Package Manager** | Sử dụng `uv` để quản lý dependencies nhanh hơn pip, với cache mount để tăng tốc rebuild. |  |
| **Alpine + Tini** | Sử dụng Alpine Linux nhẹ và tini làm init system để xử lý signals đúng cách. |  |
| **Security Patching** | Nâng cấp starlette lên 0.50.0 để fix các CVE mà không cần sửa pyproject.toml. |  |
| **Non-root User** | Tạo user nonroot với UID/GID 14406, một UID không phổ biến để tránh conflict. |  |
| **Healthcheck với curl** | Sử dụng curl để kiểm tra health endpoint và grep để verify response JSON. |  |
| **OCI Labels** | Thêm đầy đủ OCI labels với metadata về version, build date, revision, source. |  |

**Dockerfile TOP (Python)**

```
# syntax=docker/dockerfile:1.19

FROM python:3.13-alpine3.22 AS deps

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-compile uv==0.9.2

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev --no-install-project \
    && uv pip install starlette==0.50.0

FROM python:3.13-alpine3.22 AS final

RUN pip install -U pip

RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache \
    curl=8.14.1-r2 \
    tini=0.19.0-r3

ARG VERSION="0.1.0"
ARG BUILD_DATE="2025-11-10T00:00:00Z"
ARG REVISION="unknown"
ARG GIT_COMMIT_SHA="unknown"

LABEL org.opencontainers.image.title="python-service-template" \
      org.opencontainers.image.description="A batteries-included template for building robust, production-ready Python backend services with FastAPI" \
      org.opencontainers.image.authors="Khiem Doan" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$REVISION \
      org.opencontainers.image.source="https://github.com/khiemdoan/" \
      org.opencontainers.image.licenses="MIT"

ENV USER=nonroot \
    GROUP=nonroot \
    UID=14406 \
    GID=14406

RUN addgroup -g "$GID" "$GROUP" \
    && adduser -D -u "$UID" -G "$GROUP" "$USER"

USER $USER

WORKDIR /app

COPY --chown=$USER:$GROUP src/ src/

COPY --from=deps --chown=$USER:$GROUP /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONPATH="/app/src" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    HOST=0.0.0.0 \
    PORT=3000 \
    WORKERS=1 \
    LOGGING__LEVEL=INFO \
    LOGGING__FORMAT=PLAIN \
    COFFEE_API__HOST=https://api.sampleapis.com/coffee/ \
    APP_VERSION=$VERSION \
    GIT_COMMIT_SHA=$GIT_COMMIT_SHA

EXPOSE $PORT

HEALTHCHECK --timeout=1s \
    CMD curl -f "http://localhost:${PORT}/health/" | grep '"heartbeat":"HEALTHY"' || exit 1

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["python", "src/python_service_template/app.py"]
```

---

## Ghi chú triển khai

- Các Dockerfile trên chỉ mang tính tham khảo kiến trúc; khi áp dụng vào dự án Python/FastAPI của bạn, hãy giữ nguyên nguyên tắc: multi-stage build, security patching, non-root user, pin SHA256 cho base images.
- **Distroless vs Alpine**: Distroless an toàn hơn (không có shell, package manager) nhưng cần copy shared libraries thủ công. Alpine nhẹ và dễ debug hơn nhưng có thể gặp vấn đề tương thích với một số Python packages.
- **UV vs PIP**: UV nhanh hơn pip đáng kể (10-100x) và quản lý virtual environment tốt hơn, nhưng cần cài đặt thêm.
- **Security**: Luôn cập nhật dependencies để fix CVE, đặc biệt là các package phổ biến như starlette, fastapi, uvicorn.
- **Healthcheck**: Nên sử dụng native Python `http.client` hoặc curl/wget tùy vào base image và yêu cầu bảo mật.
