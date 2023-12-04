$maxRed = 12
$maxGreen = 13
$maxBlue = 14

$content = get-content $PSScriptRoot\input.txt | ForEach-Object{ ,($_ -Split ": ") } | ForEach-Object{ ,(($_[0] -split " ")[1], (,$_[1] -split ", |; "),'','','','') }

Foreach( $game in $content )
{
    $rolls = $game[1]
    Foreach( $roll in $rolls )
    {
        $a = $roll -split " "
        if( (($a[1] -eq "red") -and ([int]$a[0] -gt $maxRed)) -or (($a[1] -eq "blue") -and ([int]$a[0] -gt $maxBlue)) -or (($a[1] -eq "green") -and ([int]$a[0] -gt $maxGreen)) )
        {
            $game[2] = "Impossible"
        }
        # $game[3] = minred $game[4] = mingreen $game[5] = minblue
        if( ($a[1] -eq "red") -and ([int]$a[0] -gt $game[3]) )
        {
            $game[3] = $a[0]
        }
        if( ($a[1] -eq "green") -and ([int]$a[0] -gt $game[4]) )
        {
            $game[4] = $a[0]
        }
        if( ($a[1] -eq "blue") -and ([int]$a[0] -gt $game[5]) )
        {
            $game[5] = $a[0]
        }
    }
}

$content | ForEach-Object{ [int]$_[3] * [int]$_[4] * [int]$_[5] } | Measure-Object -Sum | Select-Object -ExpandProperty Sum