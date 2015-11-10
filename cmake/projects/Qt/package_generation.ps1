
Param(
  [string]$root_folder,
  [string]$out_folder
)


New-Item -ItemType Directory -Force -Path $out_folder
$outLocation = Get-Item $out_folder
$destinationPath = $outLocation.FullName

$shaSummaryFile = "$destinationPath/all_sha1.txt"
echo "########## packaging QT at $root_folder to $full "


#move to the folder containing the daa
Push-Location $root_folder

#get all package by the folder name
$dir = dir $root_folder\include | ?{$_.PSISContainer}

$binFiles = dir $root_folder\bin

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
    $binList = Get-ChildItem $root_folder\bin |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"bin\$_"}
    $includeList = Get-ChildItem $root_folder\include |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"include\$_"}
    $libList = Get-ChildItem $root_folder\lib |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"lib\$_"}
    $lib_cmakeList = Get-ChildItem $root_folder\lib\cmake |  Where-Object {$_.Name -Like "*$packageName*" } | Foreach-Object {"lib\cmake\$_"}
    
    
    #add specific additional components
    $specificList = @()
    
    if ($packageName -eq "Core"){
        $exes = Get-ChildItem $root_folder\bin |  Where-Object {$_.Name -Like "*.exe" } | Foreach-Object {"bin\$_"}
        $specificList += $exes
        $specificList += "phrasebooks translations plugins/platforms"
    } 
    
    if ($packageName -eq "Gui"){
        $specificList += plugins/imageformats
    }
    #.....
    #..... 
    
    
    #make package  
    echo "tar czf $packagePath" $binList $includeList $libList $lib_cmakeList $specificList
    tar czf $packagePath $binList $includeList $libList $lib_cmakeList $specificList
    Move-Item $packagePath $destinationPath\$packagePath
   
    #get fingerprint
    $shaResult = (openssl sha1 $destinationPath\$packagePath)
    
    #append sha to summary file 
    $componentLine =  "Qt$packageName`t";
    $componentLine += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value
    echo $componentLine | Add-Content $shaSummaryFile
   
}

pop-location