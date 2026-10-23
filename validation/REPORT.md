# Validation report

- Linux Release build: PASS (GCC 14.2.1, C++20).
- All registered CTest tests: PASS, 1,266 / 1,266.
- Included groups: 1,234 unit, 19 sound, 13 functional tests.
- RemovedRadarSettingIsIgnored: PASS (legacy config has RadarEnabled=true).
- Embedded Panorama JavaScript syntax: PASS after concatenating four C++ raw string fragments.
- GitHub Actions workflow YAML parsing: PASS.
- git diff --check: PASS.
- Windows compilation: NOT RUN; MSVC/Windows SDK unavailable in this environment.
- Build-Windows.ps1: supplied, not executed on Windows.
- CS2 in-game verification: NOT RUN.
- No Windows DLL is included. The successfully built Linux ELF .so is not a replacement for a DLL.
- No remote repository writes, workflow dispatches, releases, or pull requests were performed during this initial local validation phase.

The source package contains build logs but no Git history or dependency checkouts.
