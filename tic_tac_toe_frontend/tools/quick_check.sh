#!/usr/bin/env bash
# Minimal CI helper to run flutter analyze and a lean Gradle assembleDebug with strict resource limits.
# Non-interactive, concise logs, and safe for small CI runners.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Fast static analysis (will exit quickly on success or error)
echo "[quick_check] Running flutter analyze..."
( cd "$ROOT_DIR" && flutter analyze --no-fatal-infos --no-fatal-warnings ) || {
  echo "[quick_check] flutter analyze failed."
  exit 1
}

# Lean Android assemble (single worker, no parallel, low memory)
echo "[quick_check] Running Gradle :app:assembleDebug..."
( cd "$ROOT_DIR/android" && \
  ./gradlew :app:assembleDebug \
    --no-daemon \
    --no-parallel \
    --max-workers=1 \
    -Dorg.gradle.jvmargs="-Xmx1024m -XX:MaxMetaspaceSize=256m -Dfile.encoding=UTF-8" \
    -Dorg.gradle.vfs.watch=false \
    -Dkotlin.daemon.jvm.options=-Xmx512m \
    --warning-mode=all \
    -q \
) || {
  echo "[quick_check] Gradle assembleDebug failed."
  exit 2
}

echo "[quick_check] OK"
