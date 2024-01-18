function Get-Stationshuiskamer
{
    [CmdletBinding()]
    param
    (
    )

    ConvertTo-HtmlDocument -Uri https://www.stationshuiskamer.nl/locaties/
    | Select-HtmlNode -CssSelector '.l-locations__item' -All
    | ForEach-Object {
        $OpeningHours = $_
        | Select-HtmlNode -CssSelector '.c-card__scheduleItem' -All
        | ForEach-Object {
            $Spans = $_ | Select-HtmlNode -CssSelector 'span' -All

            [PSCustomObject]@{
                PSTypeName = 'UncommonSense.Stationshuiskamer.OpeningHours'
                Weekday    = $Spans[1] | Get-HtmlNodeText
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