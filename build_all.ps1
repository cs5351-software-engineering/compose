# Store the current directory in a variable
$currentDir = Get-Location

function BuildDevelopReleaseImage {
    param (
        [string]$folder_name
    )
    
    Set-Location .\$folder_name\$folder_name\

    # Build develop image
    Write-Host "\n[$folder_name] Building develop image..."
    & .\build.develop.ps1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Develop image built successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to build develop image." -ForegroundColor Red
        exit 1
    }

    # Build release image
    Write-Host "\n[$folder_name] Building release image..."
    & .\build.release.ps1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "[$folder_name] Release image built successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to build release image." -ForegroundColor Red
        exit 1
    }

}

BuildDevelopReleaseImage backend

# Return to the original directory
Set-Location $currentDir
