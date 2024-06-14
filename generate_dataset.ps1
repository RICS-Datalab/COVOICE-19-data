# Define the folder paths
$DataFolder = "data"
$ExtractedFolder = "extracted_data"

# Function to check if a command exists
function CommandExists {
    param (
        [string]$Command
    )
    $commandPath = Get-Command $Command -ErrorAction SilentlyContinue
    return $commandPath -ne $null
}

# Check for Expand-Archive command
if (-not (CommandExists "Expand-Archive")) {
    Write-Host "Expand-Archive command is not found. This command is available in PowerShell 5.0 and above."
    Write-Host "Please update your PowerShell version to 5.0 or above."
    exit 1
}

# Create the extracted folder if it doesn't exist
if (-not (Test-Path -Path $ExtractedFolder)) {
    New-Item -ItemType Directory -Path $ExtractedFolder
}

# Navigate to the data folder
Set-Location $DataFolder

# Combine the multi-part zip files
$combinedZip = "combined_dataset.zip"
Get-ChildItem -Filter "dataset.zip.*" | Sort-Object Name | Get-Content -Raw | Set-Content -Path $combinedZip

# Unzip the combined zip file
Expand-Archive -Path $combinedZip -DestinationPath "..\$ExtractedFolder"

# Clean up the combined zip file
Remove-Item $combinedZip

Write-Host "Extraction completed. Files are available in the '$ExtractedFolder' folder."
