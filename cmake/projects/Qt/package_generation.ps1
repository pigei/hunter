
Param(
  [string]$root_folder,
  [string]$build,
  [string]$out_folder
)


New-Item -ItemType Directory -Force -Path $out_folder
$outLocation = Get-Item $out_folder
$destinationPath = $outLocation.FullName

$shaName = $build
$shaName += "_sha1.txt"
$shaSummaryFile = "$destinationPath/$shaName"
echo "########## packaging QT at $root_folder/$build to $full "


#move to the folder containing the daa
Push-Location $root_folder

#create empty file to keep tar structure
$tar_base = "pack"
echo "" | Out-File $tar_base -Encoding "ASCII"


#get all package by the folder name
$dir = dir $build\include | ?{$_.PSISContainer}

$binFiles = dir $build\bin

#initalize summary file
echo "####SHA1 fingerprints for QT packages####`t" | Out-File $shaSummaryFile -Encoding "ASCII"


foreach ($d in $dir){

    #strip qt from names
    $packageName =  $d.Name

    
    if ($packageName.StartsWith("Qt")){
        $packageName  =$packageName.Substring(2)
    }
    $package_name_lo = $packageName.toLower()
    
    #define destination file names
    $packagePath = "qt$package_name_lo.tar.gz"
    #$sha1Path = "$destinationPath\Qt$packageName.sha1"
 
    echo "Packaging Qt$packageName into $packagePath"    

    #base structure contains bin, lib and include plus cmake configurations
    $binList = Get-ChildItem $build/bin |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"$build/bin/$_"}
    $includeList = Get-ChildItem $build/include |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"$build/include/$_"}
    $libList = Get-ChildItem $build/lib |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"$build/lib/$_"}
    $lib_cmakeList = Get-ChildItem $build/lib/cmake |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"$build/lib/cmake/$_"}
    
    
    #add specific additional components
    $specificList = @()
    
    if ($packageName -eq "Core"){
        $exes = Get-ChildItem "$build/bin" |  Where-Object {$_.Name -Like "*.exe" } | Foreach-Object {"$build/bin/$_"}
        $specificList += $exes
        $specificList += "$build/mkspecs"
        $specificList += "$build/phrasebooks"
        $specificList += "$build/translations"
        $specificList += "$build/plugins/platforms"
    } 
    
    if ($packageName -eq "Gui"){
        $specificList += "$build/plugins/imageformats"
        $specificList += "$build/plugins/generic"
    }
    if ($packageName -eq "Network"){
        $specificList += "$build/plugins/bearer"
    }
    #.....
    #..... 
    
    
    #make package  
    echo "tar czf $packagePath" $binList $includeList $libList $lib_cmakeList $specificList
    tar czf $packagePath $tar_base $binList $includeList $libList $lib_cmakeList $specificList
      
    Move-Item $packagePath $destinationPath\$packagePath

    #get fingerprint
    $shaResult = (openssl sha1 $destinationPath\$packagePath)
    
    #append sha to summary file 
    $componentLine =  "Qt$packageName`t";
    $componentLine += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value
    echo $componentLine | Add-Content $shaSummaryFile
   
}

pop-location