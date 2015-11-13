
Param(
  [string]$root_folder,
  [string]$msvcRuntime,
  [string]$arch,
  [string]$out_folder
)


New-Item -ItemType Directory -Force -Path $out_folder

$outLocation = Get-Item $out_folder
$destinationPath = $outLocation.FullName

$arch_opencv = $arch -replace "amd64$", "x64"
echo  $arch_opencv

$msvc_opencv = $msvcRuntime -replace "msvc", "vc" -replace "2013", "12"  -replace "2010", "11"


$inSubfolder = "$arch_opencv\$msvc_opencv"
$outSubfolder = "$msvcRuntime-$arch"

New-Item -ItemType Directory -Force -Path "$out_folder/$outSubfolder"

echo "########## packaging OpenCV at $root_folder/$inSubfolder to $destinationPath/$outSubfolder"


#move to the folder containing the data
Push-Location $root_folder

#create empty file to keep tar structure
$tar_base = "pack"
echo "" | Out-File $tar_base -Encoding "ASCII"

    
New-Item -ItemType Directory -Force -Path "$destinationPath/$outSubfolder"
    
#initalize summary file
$shaSummaryFile = "$destinationPath\$outSubfolder\dynamic_sha1.txt"
echo "####SHA1 fingerprints for OpenCV packages ($outSubfolder)####`t" | Out-File $shaSummaryFile -Encoding "ASCII"
      
$shaSummaryFile_static = "$destinationPath\$outSubfolder\static_sha1.txt"
echo "####SHA1 fingerprints for OpenCV packages static ($outSubfolder)####`t" | Out-File $shaSummaryFile_static -Encoding "ASCII"
    
$allLibs = dir include/opencv2 | ?{$_.PSISContainer}

#the list of library added to the sha files 
$lib_done = @()


foreach($f in $allLibs){
    #define component name
    $componentName = $f.Name
    if ($componentName -eq ""){
     continue;
    }
    
    $componentName_lo = $componentName.toLower()
    
 
    #define destination file names
    $d_packagePath = "opencv_$componentName_lo.tar.gz" 
    $s_packagePath = "libopencv_$componentName_lo.tar.gz" 
 
    
    $includeFolder = "include/opencv2/$componentName"
    
    $dynamic_ComponentFiles = dir "$inSubfolder\bin\opencv_$componentName*.*" | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
    $dynamic_ComponentFiles += dir "$inSubfolder\lib\opencv_$componentName*.*" | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }

    $static_ComponentFiles = dir "$inSubfolder\staticlib\opencv_$componentName*.*" | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }

    $static_additional = @()
    $dynamic_additional = @()

    if ($componentName -eq "core"){ #additional elements
      $static_additional =  dir "$inSubfolder\staticlib\*.cmake"  | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
      $static_additional += dir "include\opencv2\*.hpp"  | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
      $static_additional += "*.cmake"
            
      $dynamic_additional =  dir "$inSubfolder\lib\*.cmake"  | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
      $dynamic_additional += dir "$inSubfolder\bin\*.exe"  | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
      $dynamic_additional += dir "include\opencv2\*.hpp"  | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
      $dynamic_additional += "*.cmake"
    } 


    #make dynamic package  
    if (-Not(Test-Path $destinationPath\$outSubfolder\$d_packagePath) ){ 
      echo "###### Packaging component $componentName_lo `t(in $destinationPath\$outSubfolder\$d_packagePath)"  
      tar czf $d_packagePath  $includeFolder $dynamic_ComponentFiles $dynamic_additional $tar_base
      Move-Item $d_packagePath $destinationPath\$outSubfolder\$d_packagePath

    }
    
    if ($lib_done -notcontains "opencv_$componentName_lo"){
   
        #get fingerprint
        $shaResult = (openssl sha1 $destinationPath\$outSubfolder\$d_packagePath)
        
        #append sha to summary file 
        $componentLine =  "opencv_$componentName_lo`t";
        $componentLine += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value
        echo $componentLine | Add-Content $shaSummaryFile
        
        $lib_done +="opencv_$componentName_lo"
        
        echo  $componentLine
    }
    
    
    
    
    
    #make static package  
    if (-Not(Test-Path $destinationPath\$outSubfolder\$s_packagePath) ){ 
      echo "###### Packaging component libopencv_$componentName_lo `t(in $destinationPath\$outSubfolder\$d_packagePath)"  
      tar czf $s_packagePath  $includeFolder $static_ComponentFiles $tar_base
      Move-Item $s_packagePath $destinationPath\$outSubfolder\$s_packagePath
      $static_done = true
    }
    if ($lib_done -notcontains "libopencv_$componentName_lo"){
        #get fingerprint
        $shaResult = (openssl sha1 $destinationPath\$outSubfolder\$s_packagePath)
        
        #append sha to summary file 
        $componentLine =  "libopencv_$componentName_lo`t";
        $componentLine += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value
        echo $componentLine | Add-Content $shaSummaryFile_static
        
        $lib_done +="libopencv_$componentName_lo"
        echo  $componentLine
    }
    
   
}  



pop-location