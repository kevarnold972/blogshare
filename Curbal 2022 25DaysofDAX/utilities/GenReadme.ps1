$StartLocation = Get-Location
$FilePath = $StartLocation.Path #+ '\Curbal 2022 25DaysofDAX'
$FilePath = $FilePath.Replace("\utilities","")
$ReadMe = $FilePath + '\README.md'
$Answers = $FilePath + "\answers"

Write-Output $FilePath
Write-Output $ReadMe

$FilestoProcess = Get-ChildItem -Path $Answers -Filter "*.dax"

$Dayfunctions = [System.Collections.ArrayList]::new()

foreach ($f in $FilestoProcess) {
    foreach ($l in Get-Content $f.FullName) {
        
        foreach ($w in $l.Split(" ")){
           if ( $w.EndsWith("(") ){
            $day = $f.Name.Replace($f.Extension,"")
            [void]$Dayfunctions.Add( 
                [PSCustomObject]@{
                    Day = $day
                    FunctionName =$w.Replace("(","")
                    KeyVal = $f.Name.Replace($f.Extension,"") + $w.Replace("(","")
                    DaySortKey = [int]$day.Replace("Day","")
                    FileName = $f.FullName
                }
            )
           }
        }
    }
}

$UniqueFunctions = $Dayfunctions | Sort-Object -Property KeyVal -Unique 

$Intro = @"
This folder contains my answers to the Curbal 2022 #25DaysOfDAXFridays challenge Ed2:World Cup. 
This year I decided to create all of my answers with DAX queries, instead of producing measures in Power BI.
This give a little twist to the code. BTW, it cannot be pasted as-in into a PBIX file. Instead run these with DAX Studio
or Tabular Editor.
Find the questions at https://curbal.com/25-days-of-dax-fridays-challenge-ed2-world-cup-data
"@

$Intro | Out-File $ReadMe

foreach ($d in $UniqueFunctions | Select-Object -Property Day, DaySortKey, Filename  | 
                        Sort-Object -Property Day -Unique | Sort-Object -Property DaySortKey -Descending){
    # $d.Day 
    # $d.DaySortKey
    "# " + $d.Day | Out-File $ReadMe -Append
    '## Functions used:' | Out-File $ReadMe -Append
    foreach ($df in $UniqueFunctions | Where-Object -FilterScript {$_.Day -eq $d.Day} | Select-Object -Property FunctionName ){
        "- [" + $df.FunctionName + "](https://dax.guide/" + $df.FunctionName + ")" | Out-File $ReadMe -Append
    }
    '## DAX Code:' | Out-File $ReadMe -Append
    '```' | Out-File $ReadMe -Append
    Get-Content $d.Filename | Out-File $ReadMe -Append
    '```' | Out-File $ReadMe -Append
    
}