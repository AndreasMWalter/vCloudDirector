function Get-VcdTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$TaskId,
        [Parameter(Mandatory = $false)][ValidateNotNull()][string]$APIurl = $GlobalvCDAPIUri,
        [Parameter(Mandatory = $false)][ValidateNotNull()]$Session = $GlobalvCDSession
    )
    Process {
        try {
            $Uri = $APIurl + "/task/$TaskId"
            $Task = Invoke-RestMethod -Uri $Uri -Method GET -WebSession $Session -ErrorAction Stop -Verbose:$false
            $Task.Task.id = $Task.Task.id -replace 'urn:vcloud:task:',''
            Return $Task.Task
        } catch {
            throw "Could not query task"
        }
    }
}