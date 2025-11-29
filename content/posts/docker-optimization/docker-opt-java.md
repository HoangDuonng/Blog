---
title: "Tối ưu Docker cho Java"
author: "Hoàng Dương"
date: "2025-11-29"
draft: false
description: "Phân tích các kỹ thuật tối ưu Dockerfile từ Dockerfile Contest 2025 cho ứng dụng Java Spring Boot."
categories: ["Docker Optimization"]
tags: ["docker", "java", "spring-boot", "performance"]
image: "images/docker-optimization/docker-optimization-java.webp"
license: "DevOpsVN"
---

## Dockerfile Contest 2025 – Java tối ưu extreme

Dockerfile Contest 2025 thúc đẩy cộng đồng DevOps Việt Nam đánh giá lại cách viết Dockerfile để đạt **bảo mật, tối ưu, tường minh**. Bài viết này tổng hợp riêng cho hạng mục **Java Spring Boot**, nơi các tác giả tập trung tối ưu JRE, giảm kích thước image và chuẩn hóa quy trình build.

---

## I. Hạng mục JAVA (Spring Boot Service)

Hạng mục Java tập trung vào các ý tưởng:

- **Tối ưu JRE**: dùng `jlink` và `jdeps` để tạo custom JRE chỉ chứa module cần thiết.
- **Tối ưu security & dependency**: tự động cập nhật dependency an toàn, giảm CVE.
- **Multi-stage build**: tách rõ stage build và runtime, dùng distroless hoặc base image tối ưu.
- **Healthcheck rõ ràng**: dùng `wget` hoặc Java native healthcheck để giám sát container.

### 1. Dockerfile TOP 1 (Java) – Spring Boot Template + Distroless

| Kỹ thuật | Giải thích theo tác giả | Nguồn tham khảo |
| --- | --- | --- |
| **Custom JRE bằng jlink** | Dùng `jdeps` phân tích fat JAR để lấy danh sách module, sau đó `jlink` tạo JRE chỉ chứa module cần, giảm đáng kể kích thước runtime. |  |
| **Multi-stage build rõ ràng** | Stage `build` dùng `eclipse-temurin:21-jdk` để build Gradle; stage runtime dùng `gcr.io/distroless/base-debian12` chỉ chạy JRE. |  |
| **Phân tách Healthcheck Stage** | Tạo stage `healthcheck` dùng BusyBox, copy `wget` vào runtime để healthcheck mà không phải cài thêm full curl/wget từ package manager. |  |
| **Distroless Runtime** | Dùng distroless base để giảm attack surface (không shell, không package manager), image gọn và an toàn hơn. |  |
| **Pin nguồn & license** | Thêm LABEL `org.opencontainers.image.source`, `version`, `licenses` để dễ truy vết source code và tuân thủ license. |  |

**Dockerfile TOP 1 (JAVA)**

```
# Build stage
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

# Copy gradle wrapper and properties first for better caching
COPY gradlew gradlew.bat build.gradle ./
COPY gradle/ gradle/

# Download Gradle distribution (cached)
RUN --mount=type=cache,target=/root/.gradle ./gradlew --version

# Copy source code
COPY src/ src/

# Build the application
RUN --mount=type=cache,target=/root/.gradle ./gradlew --no-daemon clean bootJar \
    -Dspring-framework.version=6.2.11 \
    -Dtomcat.version=10.1.47

# Extract the application dependencies
RUN jar xf build/libs/spring-boot-template.jar

# Analyze the dependencies contained into the fat jar
RUN jdeps --ignore-missing-deps -q  \
  --recursive  \
  --multi-release 21  \
  --print-module-deps  \
  --class-path 'BOOT-INF/lib/*'  \
  build/libs/spring-boot-template.jar > deps.info

# Create the custom JRE
RUN jlink \
  --verbose \
  --add-modules $(cat deps.info) \
  --compress zip-9 \
  --no-header-files \
  --no-man-pages \
  --output /custom_jre

# Healthcheck stage
FROM busybox:1.36.0-musl AS healthcheck

# Runtime stage
FROM gcr.io/distroless/base-debian12
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"
COPY --from=build /custom_jre $JAVA_HOME

# Copy wget for healthcheck
COPY --from=healthcheck /bin/wget /usr/bin/wget

WORKDIR /app

# Copy application insights config
COPY lib/applicationinsights.json ./

# Copy the built JAR
COPY --from=build /app/build/libs/spring-boot-template.jar /app.jar

# Add labels
LABEL org.opencontainers.image.source="https://github.com/hmcts/spring-boot-template" \
  org.opencontainers.image.version="0.0.1" \
  org.opencontainers.image.licenses="MIT"

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD ["/usr/bin/wget", "--quiet", "--output-document=/dev/null", "http://localhost:8080/health"]

CMD ["java", "-jar", "/app.jar"]
```

---

### 2. Dockerfile TOP 2 (Java) – Gradle Auto Dependency Update + Custom Healthcheck

| Kỹ thuật | Giải thích theo tác giả | Nguồn tham khảo |
| --- | --- | --- |
| **Gradle Dependency Updates** | Dùng plugin `dependencyUpdates` để sinh report, sau đó script shell parse report và tự động update version plugin/ext/dependency trong `build.gradle`. |  |
| **Force Dependency Upgrade** | Biến `DEPENDENCIES_FORCE_UPDATE` cho phép chỉ định `group:name:version` để ép cập nhật những dependency quan trọng, thường là những lib dính CVE. |  |
| **Native Java Healthcheck** | Viết class `HealthCheck.java` dùng `HttpURLConnection` gọi `/health`, giúp healthcheck không phụ thuộc curl/wget. |  |
| **Distroless Base Java** | Runtime dùng `hmctspublic.azurecr.io/base/java:21-distroless`, image Java 21 tối ưu sẵn cho production. |  |
| **Cache Gradle** | Mount cache `/root/.gradle` để tăng tốc `./gradlew` trong stage build. |  |

**Dockerfile TOP 2 (JAVA)**

```
# Stage 1 — Build application using Gradle
FROM gradle:8.14.3-jdk21-alpine AS builder

WORKDIR /app

# Caching wrapper and build configuration before build 
COPY gradlew ./
COPY gradle gradle
COPY build.gradle build.gradle

# Caching gradle/download
RUN ./gradlew --no-daemon help

# Copy src code
COPY src/main src/main

# Check dependency need to update
RUN ./gradlew --no-daemon dependencyUpdates -Drevision=release

# Auto update for auto vulnerability fixing 
RUN REPORT_FILE="build/dependencyUpdates/report.txt" && \
    echo "=== Parsing $REPORT_FILE ===" && \
    \
    PLUGINS_TO_UPGRADE=${PLUGINS_TO_UPGRADE:-"org.springframework.boot org.sonarqube com.github.ben-manes.versions uk.gov.hmcts.java"} && \
    EXTS_TO_UPGRADE=${EXTS_TO_UPGRADE:-"org.apache.logging.log4j ch.qos.logback"} && \
    DEPENDENCIES_FORCE_UPDATE=${DEPENDENCIES_FORCE_UPDATE:-"org.apache.commons:commons-lang3:3.19.0"} && \
    \
    escape_sed() { printf '%s\n' "$1" | sed 's/[.[\*^$/&]/\\&/g'; } && \
    \
    # --- Plugin updates ---
    for plugin in $PLUGINS_TO_UPGRADE; do \
    LINE=$(grep -A1 "$plugin" "$REPORT_FILE" | grep '\[' | head -1 || true); \
    OLD_VERSION=$(echo "$LINE" | sed -E 's/.*\[(.*) -> .*\].*/\1/' || true); \
    NEW_VERSION=$(echo "$LINE" | sed -E 's/.*\[.* -> (.*)\].*/\1/' || true); \
    if [ -n "$NEW_VERSION" ] && [ "$NEW_VERSION" != "$OLD_VERSION" ]; then \
    echo "===== Upgrading plugin $plugin: $OLD_VERSION → $NEW_VERSION"; \
    ESC_OLD=$(escape_sed "$OLD_VERSION"); \
    ESC_NEW=$(escape_sed "$NEW_VERSION"); \
    sed -i "s#id '$plugin' version '$ESC_OLD'#id '$plugin' version '$ESC_NEW'#g" build.gradle; \
    fi; \
    done && \
    \
    # --- ext{} version updates ---
    for prefix in $EXTS_TO_UPGRADE; do \
    LINE=$(grep -A1 "$prefix" "$REPORT_FILE" | grep '\[' | head -1 || true); \
    OLD_VERSION=$(echo "$LINE" | sed -E 's/.*\[(.*) -> .*\].*/\1/' || true); \
    NEW_VERSION=$(echo "$LINE" | sed -E 's/.*\[.* -> (.*)\].*/\1/' || true); \
    if [ -n "$NEW_VERSION" ] && [ "$NEW_VERSION" != "$OLD_VERSION" ]; then \
    echo "===== Upgrading prefix $prefix: $OLD_VERSION → $NEW_VERSION"; \
    ESC_OLD=$(escape_sed "$OLD_VERSION"); \
    ESC_NEW=$(escape_sed "$NEW_VERSION"); \
    sed -i "s/\"$ESC_OLD\"/\"$ESC_NEW\"/g" build.gradle; \
    fi; \
    done && \
    \
    # --- Force dependency updates with explicit GAV ---
    for dep in $DEPENDENCIES_FORCE_UPDATE; do \
    GROUP=$(echo "$dep" | cut -d':' -f1); \
    NAME=$(echo "$dep" | cut -d':' -f2); \
    NEW_VERSION=$(echo "$dep" | cut -d':' -f3); \
    if [ -z "$GROUP" ] || [ -z "$NAME" ] || [ -z "$NEW_VERSION" ]; then \
    echo "======  Invalid DEPENDENCIES_FORCE_UPDATE format for $dep, expected group:name:version"; \
    continue; \
    fi; \
    echo "====== Forcing dependency update: $GROUP:$NAME → $NEW_VERSION"; \
    ESC_GROUP=$(escape_sed "$GROUP"); \
    ESC_NAME=$(escape_sed "$NAME"); \
    ESC_NEW=$(escape_sed "$NEW_VERSION"); \
    if grep -q "$ESC_GROUP" build.gradle | grep -q "$ESC_NAME"; then \
    # Replace existing dependency version
    sed -i "s#group: '$ESC_GROUP', name: '$ESC_NAME', version: '[^']*'#group: '$ESC_GROUP', name: '$ESC_NAME', version: '$ESC_NEW'#g" build.gradle; \
    else \
    # Insert new dependency inside dependencies { }
    echo "====== Adding new dependency $GROUP:$NAME:$NEW_VERSION"; \
    sed -i "/dependencies\s*{/a\    implementation group: '$GROUP', name: '$NAME', version: '$NEW_VERSION'" build.gradle; \
    fi; \
    done && \
    \
    echo "Version upgrade complete!" && \
    cat build.gradle

# Build the application JAR after dependency check
RUN ./gradlew --no-daemon bootJar

# Generate java healthcheck class
RUN mkdir -p /app/health && cat > /app/health/HealthCheck.java <<'EOF'
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.Instant;

public class HealthCheck {
    public static void main(String[] args) {
        String healthUrl = "http://localhost:8080/health";
        try {
            URL url = new URL(healthUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(2000);
            conn.setReadTimeout(2000);
            conn.setRequestMethod("GET");

            int code = conn.getResponseCode();
            if (code == 200) {
                System.out.println(Instant.now() + "Healthcheck OK (" + code + ")");
                System.exit(0);
            } else {
                System.err.println(Instant.now() + "Healthcheck failed (" + code + ")");
                System.exit(1);
            }
        } catch (Exception e) {
            System.err.println(Instant.now() + " Healthcheck error: " + e.getMessage());
            System.exit(1);
        }
    }
}
EOF

# Compile HealthCheck.java file
RUN javac /app/health/HealthCheck.java

# Stage 2 — Runtime image (auto-updated base)
FROM hmctspublic.azurecr.io/base/java:21-distroless

WORKDIR /app

# Copy compiled app
COPY --from=builder /app/build/libs/*.jar app.jar

# Copy complied healthcheck class
COPY --from=builder /app/health/HealthCheck.class /app/HealthCheck.class

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=3 \
    CMD ["java", "HealthCheck"]
```

---

### 3. Dockerfile TOP (Java) – Dung Cao (Alpine JDK/JRE tối ưu)

| Kỹ thuật | Giải thích theo tác giả | Nguồn tham khảo |
| --- | --- | --- |
| **Tách riêng JDK/JRE bằng ARG** | Dùng `ARG BUILD_JDK_IMAGE` và `RUNTIME_IMAGE` để dễ đổi base image (JDK cho build, JRE cho runtime), vẫn giữ Dockerfile đơn giản. |  |
| **Gradle cache với BuildKit** | Dùng `--mount=type=cache,target=/cache/.gradle` cho các lệnh `./gradlew` để tối ưu thời gian build lặp lại. |  |
| **Không chạy test trong build image** | `bootJar -x test` giúp build nhanh hơn cho môi trường CI/CD và Docker contest (ưu tiên ra artifact). |  |
| **Non-root user + chown** | Tạo user/group `app`, `--chown=app:app` khi copy JAR đảm bảo runtime an toàn, tuân CIS Docker Benchmark. |  |
| **Healthcheck với curl** | Cài `curl` (apk add --no-cache) rồi dùng `curl -fsS` tới `/health` cho healthcheck rõ ràng, dễ debug. |  |
| **JVM tuning cho container** | `JAVA_OPTS` bật `UseContainerSupport`, `MaxRAMPercentage=75`, `G1GC`, `ExitOnOutOfMemoryError`, heap dump path… giúp JVM hiểu giới hạn container và fail-fast khi OOM. |  |

**Dockerfile TOP (JAVA) – Dung Cao**

```
# Dockerfile.txt
# === Alpine build optimized for Dockerfile Contest 2025 ===
# Focus: security, lightweight, clear, maintainable

# Build-time arguments
ARG BUILD_JDK_IMAGE=eclipse-temurin:21-jdk-alpine-3.22
ARG RUNTIME_IMAGE=eclipse-temurin:21-jre-alpine-3.22

# ---------- Stage: builder ----------
FROM ${BUILD_JDK_IMAGE} AS builder

# Set non-interactive environment & reproducible timezone
ENV TZ=UTC \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  GRADLE_USER_HOME=/cache/.gradle

WORKDIR /workspace

# Copy Gradle wrapper and descriptors
COPY gradlew .
COPY gradle/ gradle/
COPY build.gradle ./

RUN chmod +x ./gradlew

# Resolve dependencies using BuildKit cache mount
RUN --mount=type=cache,target=/cache/.gradle \
  ./gradlew --no-daemon dependencies || true

# Copy application source
COPY src/ src/

RUN --mount=type=cache,target=/cache/.gradle \
  ./gradlew --no-daemon clean bootJar -x test \
  -Dspring-framework.version=6.2.11 \
  -Dcommons-lang3.version=3.18.0 \
  -Dtomcat.version=10.1.47

# ---------- Stage: runtime ----------
FROM ${RUNTIME_IMAGE} AS runtime

ARG VERSION
ARG VCS_REF
ARG BUILD_DATE
ARG LICENSE="MIT License"
ARG SOURCE="contest-submission"

# OCI Labels (metadata)
LABEL org.opencontainers.image.title="spring-boot-template" \
  org.opencontainers.image.description="Spring Boot Java application built for Dockerfile Contest 2025" \
  org.opencontainers.image.url="${SOURCE}" \
  org.opencontainers.image.source="${SOURCE}" \
  org.opencontainers.image.version="${VERSION}" \
  org.opencontainers.image.revision="${VCS_REF}" \
  org.opencontainers.image.licenses="${LICENSE}" \
  org.opencontainers.image.created="${BUILD_DATE}" \
  org.opencontainers.image.authors="Dung Cao"

# Create non-root user
RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

# Copy application jar
COPY lib/applicationinsights.json applicationinsights.json
COPY --from=builder --chown=app:app /workspace/build/libs/*.jar app.jar

# Install curl for healthcheck
RUN apk add --no-cache curl \
  && rm -rf /var/cache/apk/*

# Expose HTTP port
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -fsS http://127.0.0.1:8080/health || exit 1

# JVM optimization
ENV JAVA_OPTS="\
  -XX:+UseContainerSupport \
  -XX:MaxRAMPercentage=75.0 \
  -Djava.security.egd=file:/dev/./urandom \
  -Dserver.shutdown=graceful \
  -Dspring.lifecycle.timeout-per-shutdown-phase=10s \
  -Dfile.encoding=UTF-8 \
  -XX:+ExitOnOutOfMemoryError \
  -XX:+UseG1GC \
  -XX:+HeapDumpOnOutOfMemoryError \
  -XX:HeapDumpPath=/tmp \
  "

# Graceful termination signal
STOPSIGNAL SIGTERM

# Switch to non-root user
USER app

# --- Entry point ---
ENTRYPOINT ["sh", "-c", "exec java ${JAVA_OPTS} -jar /app/app.jar"]
```

---

### 4. Dockerfile TOP (tham khảo – Java) – HMCTS Spring Boot Template (Layered + jlink)

| Kỹ thuật | Giải thích theo tác giả | Nguồn tham khảo |
| --- | --- | --- |
| **Gradle cache + tách layer** | Dùng BuildKit cache `id=gradle-cache` cho Gradle, sau đó dùng `jarmode=layertools` để extract các lớp `dependencies`, `spring-boot-loader`, `snapshot-dependencies`, `application` giúp cache Docker layer tối đa. |  |
| **Custom JRE với jlink** | Chạy `jlink` với danh sách module Java chọn tay để tạo JRE tối thiểu (`/jre-minimal`), giảm hơn 100MB so với JDK full. |  |
| **Alpine runtime tối thiểu** | Runtime base `alpine:3.21` chỉ cài `ca-certificates`, `tzdata`, `tini`, `curl`, sau đó chạy với non-root `appuser`. |  |
| **JAVA_TOOL_OPTIONS cho container** | Tối ưu JVM: `UseContainerSupport`, `MaxRAMPercentage`, `UseG1GC`, `UseStringDeduplication`, `ExitOnOutOfMemoryError`,… để tối ưu memory & GC trong container. |  |
| **OCI labels rất đầy đủ** | Ghi rõ `vendor`, `authors`, `source`, `version`, `revision`, `base.name`, `base.digest`, `com.hmcts.*`… giúp traceability cho tổ chức. |  |
| **Healthcheck dùng curl** | Healthcheck `/health` qua `curl -f`, retry có cấu hình hợp lý cho Spring Boot khởi động. |  |

**Dockerfile TOP (tham khảo – JAVA) – HMCTS Spring Boot Template**

```
# syntax=docker/dockerfile:1.7

# ============================================================================
# STAGE 1: Application builder with optimized caching
# ============================================================================
FROM eclipse-temurin:21-jdk-alpine@sha256:89517925fa675c6c4b770bee7c44d38a7763212741b0d6fca5a5103caab21a97 AS builder

# Install build dependencies (minimal)
RUN apk add --no-cache binutils && \
  rm -rf /var/cache/apk/*

WORKDIR /build

# Copy Gradle wrapper and dependency definition files first
# This layer will be cached until these files change
COPY gradle/ gradle/
COPY gradlew build.gradle ./

# Download dependencies with BuildKit cache mount for faster subsequent builds
RUN --mount=type=cache,id=gradle-cache,target=/root/.gradle,sharing=locked \
  chmod +x gradlew && \
  ./gradlew dependencies --no-daemon --parallel --console=plain

# Copy only production source code (exclude tests, docs, etc.)
COPY src/main/ src/main/

# Build optimized JAR with cache mount
RUN --mount=type=cache,id=gradle-cache,target=/root/.gradle,sharing=locked \
  ./gradlew bootJar --no-daemon --parallel --console=plain -x test && \
  mkdir -p /app && \
  mv build/libs/spring-boot-template.jar /app/app.jar

# Extract Spring Boot layers for optimal Docker layer caching
WORKDIR /app
RUN java -Djarmode=layertools -jar app.jar extract --destination /app/extracted

# Create minimal custom JRE with jlink (reduces size by >100MB)
# Only include Java modules actually needed by Spring Boot
RUN $JAVA_HOME/bin/jlink \
  --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management,java.management.rmi,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.security.jgss,java.security.sasl,java.sql,jdk.httpserver,jdk.jfr,jdk.unsupported \
  --strip-debug \
  --no-man-pages \
  --no-header-files \
  --compress=zip-9 \
  --output /jre-minimal

# ============================================================================
# STAGE 3: Minimal runtime image
# ============================================================================
FROM alpine:3.21@sha256:5405e8f36ce1878720f71217d664aa3dea32e5e5df11acbf07fc78ef5661465b

# Install only critical runtime dependencies
# ca-certificates: for HTTPS connections
# tini: proper init system for PID 1
# tzdata: timezone support
# curl: for healthcheck
RUN apk upgrade --no-cache && \
  apk add --no-cache \
  ca-certificates \
  tzdata \
  tini \
  curl && \
  rm -rf /var/cache/apk/* /tmp/*

# Create non-root user for security (CIS Docker Benchmark compliance)
RUN addgroup -g 1654 -S appgroup && \
  adduser -u 1654 -S appuser -G appgroup

# Copy minimal custom JRE from builder
COPY --from=builder --chown=1654:1654 /jre-minimal /opt/java

# Set up application directory with proper ownership
WORKDIR /app

# Copy Spring Boot layers in optimal order (least to most frequently changed)
# This maximizes Docker layer cache efficiency
COPY --from=builder --chown=1654:1654 /app/extracted/dependencies/ ./
COPY --from=builder --chown=1654:1654 /app/extracted/spring-boot-loader/ ./
COPY --from=builder --chown=1654:1654 /app/extracted/snapshot-dependencies/ ./
COPY --from=builder --chown=1654:1654 /app/extracted/application/ ./

# Switch to non-root user (security best practice)
USER 1654:1654

# Set JAVA_HOME and PATH
ENV JAVA_HOME=/opt/java \
  PATH="/opt/java/bin:${PATH}"

# Optimal JVM flags for containerized Spring Boot applications
# - UseContainerSupport: respect container memory limits
# - MaxRAMPercentage: use max 75% of container memory for heap
# - UseG1GC: best GC for containers with predictable pause times
# - UseStringDeduplication: reduce memory footprint
# - ExitOnOutOfMemoryError: fail fast on OOM
# - TieredCompilation with level 1: faster startup, good for short-lived containers
ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport \
  -XX:MaxRAMPercentage=75.0 \
  -XX:InitialRAMPercentage=50.0 \
  -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=100 \
  -XX:+UseStringDeduplication \
  -XX:+ParallelRefProcEnabled \
  -XX:+DisableExplicitGC \
  -XX:+ExitOnOutOfMemoryError \
  -Djava.security.egd=file:/dev/./urandom \
  -Djava.awt.headless=true"

# Application server port
EXPOSE 8080

# Comprehensive OCI labels for traceability and compliance
LABEL org.opencontainers.image.title="Spring Boot Template" \
  org.opencontainers.image.description="HMCTS Spring Boot Template - Optimized for Contest 2025" \
  org.opencontainers.image.vendor="HMCTS Reform Programme" \
  org.opencontainers.image.authors="HMCTS <hmcts@justice.gov.uk>" \
  org.opencontainers.image.source="https://github.com/hmcts/spring-boot-template" \
  org.opencontainers.image.version="0.0.1" \
  org.opencontainers.image.revision="contest-2025" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.base.name="docker.io/library/alpine:3.21" \
  org.opencontainers.image.base.digest="sha256:5405e8f36ce1878720f71217d664aa3dea32e5e5df11acbf07fc78ef5661465b" \
  maintainer="HMCTS Reform Team" \
  com.hmcts.app.name="spring-boot-template" \
  com.hmcts.build.date="2025-10-27"

# Health check using Spring Boot Actuator /health endpoint
# Using curl for lightweight health checks
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Use tini as init system for proper signal handling
# Ensures graceful shutdown and zombie process reaping
ENTRYPOINT ["/sbin/tini", "--"]

# Run Spring Boot application
# Using exec form to ensure proper signal propagation
CMD ["java", "org.springframework.boot.loader.launch.JarLauncher"]
```

---

## Ghi chú triển khai

- **Khi áp dụng cho dự án Java của bạn**, hãy giữ nguyên các nguyên tắc chính mà các Dockerfile trên thể hiện:
  - Multi-stage build rõ ràng (builder + runtime).
  - Tối ưu JRE (dùng `jdeps` + `jlink`, base image Java distroless hoặc JRE-only image).
  - Healthcheck rõ ràng (native Java hoặc wget/curl).
  - Tối ưu dependency (tự động hoặc thủ công) để giảm CVE.
- Khi copy template về dự án riêng, bạn nên:
  - Cập nhật lại `LABEL org.opencontainers.image.source` cho đúng repository của bạn.
  - Điều chỉnh endpoint healthcheck (`/health`, `/actuator/health`...) cho trùng với app thực tế.
  - Thử build và scan image với các tool như Trivy để kiểm tra security sau khi tối ưu.


