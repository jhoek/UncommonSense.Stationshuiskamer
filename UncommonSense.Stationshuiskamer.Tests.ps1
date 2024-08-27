Describe UncommonSense.Stationshuiskamer {
    BeforeAll {
        Import-Module "$PSScriptRoot/UncommonSense.Stationshuiskamer.psd1" -Force
        $Result = Get-Stationshuiskamer
    }

    It 'Returns at least 12 entries' {
        $Result.Length | Should -BeGreaterOrEqual 12
    }

    It 'Returns valid names' {
        ($Result).Name | Should -Not -BeNullOrEmpty
    }

    It 'Returns valid addresses' {
        ($Result).Address | Should -Not -BeNullOrEmpty
    }

    It 'Returns valid images' {
        ($Result).Image | Should -Not -BeNullOrEmpty
    }

    It 'Returns valid opening hours' {
        $Result | ForEach-Object { $_.OpeningHours.Length | Should -Be 7 }
        (($Result).OpeningHours).WeekDay | Should -Not -BeNullOrEmpty
        (($Result).OpeningHours).Hours | Should -Not -BeNullOrEmpty
    }
}