
describe 'New-PoshBotFileUpload' {

    BeforeAll {
        $readme = $env:bh
        $readme = Join-Path -Path $env:BHProjectPath -ChildPath 'readme.md'
    }

    it 'Returns a [PoshBot.File.Upload] object' {
        $resp = New-PoshBotFileUpload -Path $readme
        $resp.PSObject.TypeNames[0] | should be 'PoshBot.File.Upload'
    }

    it 'Will redirect to DM channel when told' {
        $resp = New-PoshBotFileUpload -Path $readme -DM
        $resp.DM | should be $true
    }

    it 'Has a valid [Title] field' {
        $resp = New-PoshBotFileUpload -Path $readme -DM -Title 'readme.md'
        $resp.Title | should be 'readme.md'
    }

    it 'Validates file exists' {
        $guid = (New-Guid).ToString()
        $badFile = Join-Path -Path $env:BHProjectPath -ChildPath "$($guid).txt"
        { New-PoshBotFileUpload -Path $badFile } | should throw
    }
}

