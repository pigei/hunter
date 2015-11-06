
Param(
  [string]$lib,
  [string]$version,
  [string]$shaSummaryFile,
  [string]$versionTemplateFile,
  [string]$downloadTemplateFile
)

$version_snake = $version -replace "\.", "_"

$outFile = "./cmake/components_version$version_snake.cmake"

echo "####Getting informations from $shaSummaryFile"

$template = (Get-Content $versionTemplateFile)
$template = $template -replace "@libName@", "$lib"
$template = $template -replace "@libVersion@", "$version"

$templateHunter = (Get-Content $downloadTemplateFile)

echo "####Component url and fingerprints" | Out-File $outFile -Encoding "ASCII"

Get-Content( $shaSummaryFile ) | Foreach-Object {
    $reg = [regex]::match($_, "([a-zA-Z_.]+)\t([a-z0-9.]+)")
    if ($reg.Success){
        $packageName = $reg.Groups[1].Value
        $packageSha  = $reg.Groups[2].Value
        
        echo "adding $packageName"
        
        $mt = $template -replace "@packageName@", "$packageName"
        $mt = $mt -replace "@packageSha@", "$packageSha"
       
        echo $mt | Add-Content $outFile
  
        
        
        ##then create the component folder
        $folderName = $packageName.toLower()
        $PACKAGE_NAME = $packageName.toUpper()
        New-Item -ItemType Directory -Force -Path $folderName
        
        $mt = $templateHunter -replace "@qt_component@", $folderName
        $mt = $templateHunter -replace "@QT_COMPONENT@", $PACKAGE_NAME

        echo $mt | Out-File "$folderName/hunter.cmake" -Encoding "ASCII"

    }
}