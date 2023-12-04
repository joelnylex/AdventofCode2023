$maxRed = 12
$maxGreen = 13
$maxBlue = 14

$content = get-content $PSScriptRoot\input.txt | ForEach-Object{ ,($_ -Split ": ") } | ForEach-Object{ ,(($_[0] -split " ")[1], (,$_[1] -split ", |; "),"") }

Foreach( $item in $content)
{
    $rolls = $item[1]
    Foreach( $roll in $rolls )
    {
        $a = $roll -split " "
        if( (($a[1] -eq "red") -and ([int]$a[0] -gt $maxRed)) -or (($a[1] -eq "blue") -and ([int]$a[0] -gt $maxBlue)) -or (($a[1] -eq "green") -and ([int]$a[0] -gt $maxGreen)) )
        {
            $item[2] = "Impossible"
        }
    }
}

$content | Where-Object{ $_[2] -ne "Impossible" } | ForEach-Object{ $_[0] } | Measure-Object -sum | Select-Object -ExpandProperty Sum