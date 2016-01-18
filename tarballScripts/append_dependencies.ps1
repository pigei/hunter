Param(
  [string]$hunterFile
)

foreach($i in $args)  {
        echo "hunter_add_package($i)" | Add-Content $hunterFile
}
