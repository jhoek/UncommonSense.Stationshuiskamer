Import-Module UncommonSense.Stationshuiskamer -Force

Get-Command -Module UncommonSense.Stationshuiskamer
| Sort-Object -Property Noun, Verb
| Convert-HelpToMarkDown -Preface PREFACE.md -Title UncommonSense.Stationshuiskamer -Description 'PowerShell cmdlets for retrieving Dutch Railways "Stationshuiskamer" information'
| Out-File .\README.md