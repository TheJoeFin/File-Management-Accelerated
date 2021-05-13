$dirpath = Read-Host -Prompt "Enter the full path for directory to batch and zip"

# This uses the first 11 characters of a file name to batch the .zips
$matchLength = 8

Get-ChildItem $dirpath | 
Group-Object  { $_.Name.Substring(0, $matchLength) } | 
ForEach-Object{
    $subset = $_

    # Try to skip files which don't have a part number at the start
    if($_.Name.Length -lt $matchLength) { continue }

    $subset.Group | ForEach-Object{
        $fullZipPath = $dirpath + "\" +  $_
        $fullItemPath = $dirpath + "\" + $subset.Name
        Compress-Archive $fullZipPath $fullItemPath -Update
    }
}
