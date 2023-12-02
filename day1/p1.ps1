Get-Content $PSScriptRoot\testinput.txt | ForEach-Object{ $_ -replace "[^0-9]",""  } | ForEach-Object{  $_.Substring(0,1) + $_.Substring($_.length-1,1) } | Measure-Object -Sum
