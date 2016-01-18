Param(
  [string]$lib_name,
  [string]$version,
  [string]$build,
  [string]$hunterTemplate
)


$tarball_name = "$lib_name-$version.tar.gz"

tar czf $tarball_name ($args -split ' ')
mkdir tarballs/$build
mv $tarball_name tarballs/$build

$shaResult = (openssl  sha1 tarballs/$build/$tarball_name)
$sha += [regex]::match($shaResult, ".*= ([a-z0-9.]+)").Groups[1].Value

echo $sha > ./tarballs/$build/$lib_name-$version.sha1

echo $sha

$lib_name_upper = $lib_name.toUpper()


If (Test-Path ./tarballs/hunter.cmake){
	#append sha to existing file
	$template = (Get-Content  ./tarballs/hunter.cmake)

	$newline = "SET(@lib_name@-@lib_build@_SHA  @lib_sha@)`n"

	$newline  = $newline -replace "@lib_name@", $lib_name
	$newline  = $newline -replace "@lib_build@", $build
	$newline  = $newline -replace "@lib_sha@", $sha
	$template  = $template -replace '^(?=#SHAEND)',$newline
	
} else {
	#build the hunter from scratch
	$template = (Get-Content $hunterTemplate)
	$template = $template -replace "@LIB_NAME_UPPER@", "$lib_name_upper"
	$template = $template -replace "@lib_name@", "$lib_name"
	$template = $template -replace "@lib_version@", "$version"
	$template = $template -replace "@lib_sha@", "$sha"
	$template = $template -replace "@lib_build@", "$build"
}
echo  $template  | Out-File  ./tarballs/hunter.cmake -Encoding "ASCII"
#also store the sha in the main hunter file
