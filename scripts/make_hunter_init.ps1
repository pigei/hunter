Param(
  [string]$server_url,    
  [string]$server_folder, #e.g. 1.2.0
  [string]$server_user,   #e.g. msvc2013-amd64
  [string]$sha,
  [string]$hunter_name,
  [string]$outFile
)


$template = (Get-Content scripts/gate_init.cmake.in)
$template = $template -replace "@server_url@", "$server_url"
$template = $template -replace "@server_folder@", "$server_folder"
$template = $template -replace "@server_user@", "$server_user"
$template = $template -replace "@hunter_name@", "$hunter_name"
$template = $template -replace "@sha@", "$sha"

echo $template | Out-File $outFile -Encoding "ASCII"