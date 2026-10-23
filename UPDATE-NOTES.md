# Maintenance update — 2026-10-23

## Scope

- Base fork commit: `0fda1c7456f9e2f8cf571cd364191d0c2c26e258`.
- Upstream reference: `d807476c9` (2026-10-10).
- Adopted upstream's Windows Panorama `SetImage` signature fix, Windows unity-build CI setting, `/bigobj` for MSVC unit tests, and copyright update.
- Removed the fork's in-game radar reveal implementation, UI, and active configuration state. It wrote through hard-coded Windows offsets (`0x1E88 + 0x08`), which are not validated by the pattern-search diagnostics.
- Retained read-only handling of the removed `RadarEnabled` field so old configurations still load; new configurations omit it. Added a compatibility fixture and regression test.
- Removed the branch-specific footstep preview workflow. The existing Windows CI now also builds/runs sound tests and uploads the MSVC x64 Release DLL after its tests pass.
- Preserved remaining gameplay features, footstep arrows, diagnostics, and the existing diagnostic safe-mode switch. That switch is not an anti-cheat protection mechanism.
- Corrected diagnostic wording: matching signatures do not validate every runtime schema offset.

## Build a Windows DLL locally

Requires Windows, Visual Studio 2022 with Desktop development with C++, CMake on PATH, and Git/network access for GoogleTest.

From PowerShell in the extracted project directory:

```powershell
powershell -ExecutionPolicy Bypass -File .\Build-Windows.ps1
```

The script builds Release x64, runs all registered tests, then copies the DLL and SHA-256 checksum into `dist`. Failed commands print only a short log tail; full logs remain in `build-logs`. It does not publish or upload anything.

Alternatively, the existing Windows GitHub Actions workflow can produce a DLL artifact after these sources are committed and its Windows jobs pass. The initial source archive was prepared without remote changes. Subsequent publication to a maintenance branch and CI execution were authorized separately.

## Verification limits

Upstream's newest available fix is not proof of compatibility with every subsequent CS2 update. This package has not been tested inside CS2. No anti-cheat compatibility, account safety, or ban avoidance is claimed. A Linux build is not a Windows DLL and cannot validate Windows-only compilation paths.

## Local validation result

Linux Release compilation succeeded with GCC 14.2.1. All 1,266 registered tests passed (1,234 unit, 19 sound, 13 functional). See `validation/REPORT.md` ; full logs are included in the separately delivered source archive. Windows and in-game validation were not performed; no DLL is included.
