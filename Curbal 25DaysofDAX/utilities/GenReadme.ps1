$StartLocation = Get-Location
$FilePath = $StartLocation.Path + '\Curbal 25DaysofDAX'
$ReadMe = $FilePath + '\README.md'

Write-Output $FilePath
Write-Output $ReadMe

$FilestoProcess = Get-ChildItem -Path $FilePath -Filter "*.dax"

$Dayfunctions = [System.Collections.ArrayList]::new()

foreach ($f in $FilestoProcess) {
    foreach ($l in Get-Content $f.FullName) {
        
        foreach ($w in $l.Split(" ")){
           if ( $w.EndsWith("(") ){
            [void]$Dayfunctions.Add( 
                [PSCustomObject]@{
                    Day = $f.Name.Replace($f.Extension,"")
                    FunctionName =$w.Replace("(","")
                    KeyVal = $f.Name.Replace($f.Extension,"") + $w.Replace("(","")
                }
            )
           }
        }
    }
}

$UniqueFunctions = $Dayfunctions | Sort-Object -Property KeyVal -Unique 

"DAX Functions used by day" | Out-File $ReadMe

foreach ($d in $UniqueFunctions | Select-Object -Property Day | Sort-Object -Property Day -Unique){
    #$d
    "# " + $d.Day | Out-File $ReadMe -Append
    foreach ($df in $UniqueFunctions | Where-Object -FilterScript {$_.Day -eq $d.Day} | Select-Object -Property FunctionName ){
        "- [" + $df.FunctionName + "](https://dax.guide/" + $df.FunctionName + ")" | Out-File $ReadMe -Append
    }
    #$UniqueFunctions | Where-Object -FilterScript {$_.Day -eq $d.Day}
    
}