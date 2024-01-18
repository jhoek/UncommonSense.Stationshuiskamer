function Get-Stationshuiskamer
{
    [CmdletBinding()]
    param
    (
    )

    ConvertTo-HtmlDocument -Uri https://www.stationshuiskamer.nl/locaties/
    | Select-HtmlNode -CssSelector '.l-locations__item' -All
    | ForEach-Object {
        $Schedule = $_ | Select-HtmlNode -CssSelector '.c-card__scheduleItem' -All

        $OpeningHours =
        [System.DayOfWeek]::Monday,
        [System.DayOfWeek]::Tuesday,
        [System.DayOfWeek]::Wednesday,
        [System.DayOfWeek]::Thursday,
        [System.DayOfWeek]::Friday,
        [System.DayOfWeek]::Saturday,
        [System.DayOfWeek]::Sunday
        | ForEach-Object {
            $Spans = $Schedule[$_] | Select-HtmlNode -CssSelector 'span' -All

            [PSCustomObject]@{
                PSTypeName = 'UncommonSense.Stationshuiskamer.OpeningHours'
                Weekday    = $_
                Times      = $Spans[2] | Get-HtmlNodeText
            }
        }

        [PSCustomObject]@{
            PSTypeName   = 'UncommonSense.Stationshuiskamer'
            Name         = $_ | Select-HtmlNode -CssSelector 'h3' | Get-HtmlNodeText
            Address      = $_ | Select-HtmlNode -CssSelector '.c-card__textLocation' | Get-HtmlNodeText
            Image        = ($_ | Select-HtmlNode -CssSelector 'img').GetAttributeValue('data-src', '')
            OpeningHours = $OpeningHours
        }
    }
}