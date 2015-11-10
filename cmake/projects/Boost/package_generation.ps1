
Param(
  [string]$root_folder,
  [string]$out_folder
)


New-Item -ItemType Directory -Force -Path $out_folder
$outLocation = Get-Item $out_folder
$destinationPath = $outLocation.FullName


echo "########## packaging Boost at $root_folder to $full "


#move to the folder containing the data
Push-Location $root_folder

###collect all folder
$dir = dir $root_folder | ?{$_.PSISContainer}

#create empty file to keep tar structure
$tar_base = "pack"
echo "" | Out-File $tar_base -Encoding "ASCII"


#package include folder in core
$corePackagePath = "core.tar.gz"
echo "Packaging core files into $corePackagePath"    
 
#compress if not already done
if (-Not(Test-Path $destinationPath\$corePackagePath) ){    
    tar czf $corePackagePath include boostConfig.cmake boostConfigVersion.cmake $tar_base
    Move-Item $corePackagePath $destinationPath/$corePackagePath
   }
   
#get fingerprint
$shaResult = (openssl sha1 $destinationPath\$corePackagePath)

#append sha to summary file 
$coreComponentLine =  "core`t";
$coreComponentLine += [regex]::match($shaResult, ".*= ([a-z0-9_.]+)").Groups[1].Value



foreach ($d in $dir){
    $folderName = $d.Name
    $outFolderName = $folderName -replace "x64$", "amd64" #fix naming convention to correct one
    
    if ($folderName -eq "include"){ #append the core info
        continue;     //skip
    } 
    
    echo "###($folderName)####"
    
    New-Item -ItemType Directory -Force -Path $destinationPath/$outFolderName
    
    #initalize summary file
    $shaSummaryFile = "$destinationPath\$outFolderName\dynamic_sha1.txt"
    echo "####SHA1 fingerprints for Boost packages ($outFolderName)####`t" | Out-File $shaSummaryFile -Encoding "ASCII"
      
    $shaSummaryFile_static = "$destinationPath\$outFolderName\static_sha1.txt"
    echo "####SHA1 fingerprints for Boost packages static ($outFolderName)####`t" | Out-File $shaSummaryFile_static -Encoding "ASCII"
    
    #copy core tarball
    Copy-Item $destinationPath/$corePackagePath $destinationPath\$outFolderName\$corePackagePath
   
    
    #add the core fingerprint
    echo $coreComponentLine | Add-Content $shaSummaryFile
    echo $coreComponentLine | Add-Content $shaSummaryFile_static
        
    $allLibs = dir "$folderName/*.lib"   

    #the list of library added to the sha files 
    $lib_done = @()

    
    foreach($f in $allLibs){
        #define component name
        $componentName = [regex]::match($f, "boost_([a-zA-Z_0-9.]+)-vc").Groups[1].Value
        if ($componentName -eq ""){
         continue;
        }
        
        $componentName_lo = $componentName.toLower()
        
 
        #define destination file names
        $d_packagePath = "boost_$componentName_lo.tar.gz" 
        $s_packagePath = "libboost_$componentName_lo.tar.gz" 
     
        
        $dynamic_ComponentFiles = dir "$folderName\boost_$componentName*.*" | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }
        $static_ComponentFiles = dir "$folderName\libboost_$componentName*.*" | Resolve-Path -Relative |  ForEach-Object { $_ -replace "\.\\", ""  -replace "\\",  "/" }

        if (-not $dynamic_ComponentFiles){ #this is a static only library: build both
          $dynamic_ComponentFiles = $static_ComponentFiles 
        }
      
      
        
        #make dynamic package  
        if (-Not(Test-Path $destinationPath\$outFolderName\$d_packagePath) ){ 
          echo "Packaging component boost_$componentName_lo `t(in $outFolderName)"  
          tar czf $d_packagePath $dynamic_ComponentFiles $tar_base
          Move-Item $d_packagePath $destinationPath\$outFolderName\$d_packagePath
    
        }
        
        if ($lib_done -notcontains "boost_$componentName_lo"){
       
            #get fingerprint
            $shaResult = (openssl sha1 $destinationPath\$outFolderName\$d_packagePath)
            
            #append sha to summary file 
            $componentLine =  "boost_$componentName_lo`t";
            $componentLine += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value
            echo $componentLine | Add-Content $shaSummaryFile
            
            $lib_done +="boost_$componentName_lo"
            
            echo  $componentLine
        }
        
        
        
        
        
        #make static package  
        if (-Not(Test-Path $destinationPath\$outFolderName\$s_packagePath) ){ 
          echo "Packaging component libboost_$componentName_lo `t(in $outFolderName)"  
          tar czf $s_packagePath $static_ComponentFiles $tar_base
          Move-Item $s_packagePath $destinationPath\$outFolderName\$s_packagePath
          $static_done = true
        }
        if ($lib_done -notcontains "libboost_$componentName_lo"){
            #get fingerprint
            $shaResult = (openssl sha1 $destinationPath\$outFolderName\$s_packagePath)
            
            #append sha to summary file 
            $componentLine =  "libboost_$componentName_lo`t";
            $componentLine += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value
            echo $componentLine | Add-Content $shaSummaryFile_static
            
            $lib_done +="libboost_$componentName_lo"
            echo  $componentLine
        }
        
   
    }  
    
}


pop-location