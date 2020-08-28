<#
PSLog - Version 1.1 - Release - By ItsAza
https://Github.com/ItsAza/Simple-PS-Log
#>
function Write-Log {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,HelpMessage="Message to be logged")][string]$msg,                          #Log Message
        [Parameter(Mandatory=$false,HelpMessage="Switch Parameter to include source of log call")][switch]$s, #Source switch
        [Parameter(Mandatory=$false,HelpMessage="Switch Parameter for logging Info events")][switch]$i,       #Info Tag switch
        [Parameter(Mandatory=$false,HelpMessage="Switch Parameter for logging Warning events")][switch]$w,    #Warning Tag switch
        [Parameter(Mandatory=$false,HelpMessage="Switch Parameter for logging Error events")][switch]$e,      #Error Tag switch
        [Parameter(Mandatory=$false,HelpMessage="Switch Parameter for logging Debug events")][switch]$d       #Debug Tag switch
    )
    begin {
        $cStack = Get-PSCallStack
        $PSLog_Caller = ((Get-ChildItem $MyInvocation.PSCommandPath | Select-Object -Expand Name).Split("."))[0]
        $PSLog_CallerLoc = $cStack[1].Location
        $PSLog_Date = ((get-date).ToString('d')).Replace('/','')
        $PSLog_Time = (get-date).ToString('T')
        $PSLog_Name = "$($PSLog_Caller)-$($PSLog_Date).log"
        $PSLog_Folder = ('\log\')
        $PSLog_Path = "$($PSScriptRoot)$($PSLog_Folder)"
        $PSLog_FullPath = "$($PSLog_Path)$($PSLog_Name)"
        $PSLog_Method = ('Info')
        $PSLog_Content = $msg
    }
    process {
        if ($i -and (($w) -or ($e) -or ($d))) {throw "Only one Log Type may be used at a time."}elseif($i){$PSLog_Method = "Info"}
        if ($w -and (($i) -or ($e) -or ($d))) {throw "Only one Log Type may be used at a time."}elseif($w){$PSLog_Method = "Warn"}
        if ($e -and (($w) -or ($i) -or ($d))) {throw "Only one Log Type may be used at a time."}elseif($e){$PSLog_Method = "Error"}
        if ($d -and (($w) -or ($i) -or ($e))) {throw "Only one Log Type may be used at a time."}elseif($d){$PSLog_Method = "Debug"}
        if($s){
            $PSLog_Out = ("[$($PSLog_Date) - $($PSLog_Time) - $($PSLog_Method)] >> [$($PSLog_CallerLoc)] $($PSLog_Content)")
        } else {
            $PSLog_Out = ("[$($PSLog_Date) - $($PSLog_Time) - $($PSLog_Method)] $($PSLog_Content)")
        }
    }
    end {
        if(Test-Path -Path $PSLog_FullPath){
            Add-Content -Path $PSLog_FullPath -Value $PSLog_Out
        }else{
            try {New-Item -Path $PSScriptRoot -Name $PSLog_Folder -ItemType "directory" -Force | Out-Null}
            catch {throw "Could not find folder $($PSLog_Folder) at $($PSLog_FullPath), Unable to create directory."}
            try {Add-Content -Path $PSLog_FullPath -Value $PSLog_Out}
            catch {throw "Could not Write to log file at $($PSLog_FullPath)"}
        }
        
    }
}
function Remove-Log {
    [CmdletBinding()]
    param (
    )
    begin {
        $cStack = Get-PSCallStack
        $PSLog_Caller = ((Get-ChildItem $MyInvocation.PSCommandPath | Select-Object -Expand Name).Split("."))[0]
        $PSLog_Folder = ('\log\')
        $PSLog_Path = "$($PSScriptRoot)$($PSLog_Folder)"
    }
    process {
        if(Test-Path -Path $PSLog_Path){
            $PSLog_LDirContents = Get-ChildItem -Path $PSLog_Path
            foreach ($file in $PSLog_LDirContents) {
                if($file.Name -like "*$($PSLog_Caller)*"){
                    $PSLog_RemovedLog = "$($file.Directory)\$($file.Name)"
                    Remove-Item -Path $PSLog_RemovedLog -Confirm:$false -Force
                }
            }
        }else{
            throw "Could not locate log to remove at $($PSLog_Path)"
        }
    }
    end {}
}
