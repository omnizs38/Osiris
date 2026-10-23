param([ValidateRange(1, 32)][int]$Jobs = 2)
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$build = Join-Path $root 'build-windows'
$dist = Join-Path $root 'dist'
$logs = Join-Path $root 'build-logs'
New-Item -ItemType Directory -Force -Path $logs, $dist | Out-Null
$cmake = (Get-Command cmake -ErrorAction Stop).Source
$ctest = Join-Path (Split-Path $cmake) 'ctest.exe'

function Invoke-Checked {
    param([string]$Name, [string]$Tool, [string[]]$Arguments)
    $log = Join-Path $logs "$Name.log"
    Write-Host "$Name..."
    & $Tool @Arguments *> $log
    if ($LASTEXITCODE -ne 0) {
        Get-Content $log -Tail 35 | Out-Host
        throw "$Name failed (exit $LASTEXITCODE). Full log: $log"
    }
}

Invoke-Checked 'configure' $cmake @('-S', $root, '-B', $build, '-G', 'Visual Studio 17 2022', '-A', 'x64', '-DENABLE_TESTS=unit;functional')
Invoke-Checked 'build' $cmake @('--build', $build, '--config', 'Release', '--parallel', "$Jobs")
Invoke-Checked 'tests' $ctest @('--test-dir', $build, '-C', 'Release', '--output-on-failure', '--no-tests=error', '--parallel', "$Jobs")
$dll = Join-Path $dist 'Osiris-Windows-x64.dll'
Copy-Item (Join-Path $build 'Source/Release/Osiris.dll') $dll -Force
(Get-FileHash $dll -Algorithm SHA256).Hash | Set-Content "$dll.sha256" -Encoding ascii
Write-Host "Built and tested: $dll"
Write-Host "Full logs: $logs"
