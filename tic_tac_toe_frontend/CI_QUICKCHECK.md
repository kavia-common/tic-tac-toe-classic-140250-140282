# CI Quick Check: Flutter Analyze + Android assembleDebug

This project is configured for constrained CI runners. To validate fundamentals quickly and avoid Docker timeouts:

1) Run static analysis (fast):
   flutter analyze

2) Run a lean Gradle assemble for Android (no tests/signing):

Option A (recommended): use helper script
   bash tools/quick_check.sh

Option B (manual):
   cd android
   ./gradlew :app:assembleDebug --no-daemon --no-parallel --max-workers=1 -Dorg.gradle.jvmargs="-Xmx1024m -XX:MaxMetaspaceSize=256m"

Notes:
- gradle.properties already sets conservative defaults (single worker, low Xmx).
- Prefer assembleDebug instead of full release to keep build time within short executor windows (~120s).
- If network or cache stalls occur, re-run only step 2 as needed.
