
Param(
  [string]$lib,     #e.g. boost
  [string]$version, #e.g. 1.2.0
  [string]$build,   #e.g. msvc2013-amd64
  [string]$shaSummaryFile, #e.g. all_sha.txt
  [string]$versionTemplateFile,
  [string]$downloadTemplateFile
)

echo $version
$version_snake = $version -creplace "\." , "_"
echo $version_snake
$outFile = ".\cmake\components_"
$outFile += "$version_snake"
$outFile += "_$build.cmake"

echo "####Getting informations from $shaSummaryFile"

$template = (Get-Content $versionTemplateFile)
$template = $template -replace "@libName@", "$lib"
$template = $template -replace "@libVersion@", "$version"
$template = $template -replace "@libBuild@", "$build"

$templateHunter = (Get-Content $downloadTemplateFile)

echo "####Component url and fingerprints" | Out-File $outFile -Encoding "ASCII"

Get-Content( $shaSummaryFile ) | Foreach-Object {
    $reg = [regex]::match($_, "([a-zA-Z0-9_]+)\t([a-z0-9]+)")
    if ($reg.Success){
    
    
        $packageName = $reg.Groups[1].Value
        $packageSha  = $reg.Groups[2].Value
    
        $prefix = $lib.ToLower();
        $prefix += "_"
        
        if ($packageName.ToLower().StartsWith($prefix)){
            $prefixedName = $packageName;
            $packageName = $packageName.Substring($prefix.length)
        } else {
        
            #try lib prefix
            $prefix = "lib"
            $prefix += $lib.ToLower();
            $prefix += "_"
            if ($packageName.ToLower().StartsWith($prefix)){
                $prefixedName = $packageName;
                $packageName = $packageName.Substring($prefix.length)
            } else {
                $prefixedName = $packageName
            }
        }
    
    
        $package_name_lo = $packageName.toLower()
        $PACKAGE_NAME = $packageName.toUpper()
        
        echo "adding $packageName"
        
      
        
        
        $mt = $template -replace "@packageName@", "$package_name_lo"
        $mt = $mt -replace "@prefixedName@", "$prefixedName"
        $mt = $mt -replace "@packageSha@", "$packageSha"
       
        echo $mt | Add-Content $outFile
  
        
        
        ##then create the component folder
       
        New-Item -ItemType Directory -Force -Path $package_name_lo
        
        $mt = $templateHunter -creplace "@component@", $package_name_lo
        $mt =  $mt -creplace "@COMPONENT@", $PACKAGE_NAME

        echo $mt | Out-File "./$package_name_lo/hunter.cmake" -Encoding "ASCII"

    }
}