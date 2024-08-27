Describe UncommonSense.Stationshuiskamer {
    BeforeAll {
        Import-Module "$PSScriptRoot/UncommonSense.Stationshuiskamer.psd1" -Force
        $Result = Get-Stationshuiskamer
    }

    It 'Returns at least 12 entries' {
        $Result.Length | Should -BeGreaterOrEqual 25
    }

    It 'Returns valid names' {
        $Result | ForEach-Object { $_.Name | Should -Not -BeNullOrEmpty }
    }

    It 'Returns valid images' {
        $Result | ForEach-Object { $_.Image | Should -Not -BeNullOrEmpty }
    }

    It 'Returns valid opening hours' {
        $Result | ForEach-Object {
            $_.OpeningHours.Length | Should -Be 7

            $_.OpeningHours | ForEach-Object {
                $_.WeekDay | Should -Not -BeNullOrEmpty
                $_.Hours | Should -Not -BeNullOrEmpty
            }
        }
    }
}