function Write-Log {
    [CmdletBinding(DefaultParameterSetName='-i')]
    param (
        [Parameter(ParameterSetName='-msg',Mandatory=$true)][string]$msg,   #Log Message
        [Parameter(ParameterSetName='-i',Mandatory=$false)][switch]$i,      #Info Tag switch
        [Parameter(ParameterSetName='-w',Mandatory=$false)][switch]$w,      #Warning Tag switch
        [Parameter(ParameterSetName='-e',Mandatory=$false)][switch]$e,      #Error Tag switch
        [Parameter(ParameterSetName='-d',Mandatory=$false)][switch]$d       #Debug Tag switch
    )
    begin {
        $PSLog_Name = ('')
        $PSLog_Path = ('')
        $PSLog_Date = ((get-date).ToString('d')).Replace('/','')
        $PSLog_Time = (get-date).ToString('T')
        $PSLog_Method = ('')
        if ($i=$true -and (($w=$true) -or ($e=$true) -or ($d=$true))) {throw "Only one Log Type may be used at a time."}else{$PSLog_Method = "Info"}
        if ($w=$true -and (($i=$true) -or ($e=$true) -or ($d=$true))) {throw "Only one Log Type may be used at a time."}else{$PSLog_Method = "Warning"}
        if ($e=$true -and (($w=$true) -or ($i=$true) -or ($d=$true))) {throw "Only one Log Type may be used at a time."}else{$PSLog_Method = "Error"}
        if ($d=$true -and (($w=$true) -or ($i=$true) -or ($e=$true))) {throw "Only one Log Type may be used at a time."}else{$PSLog_Method = "Debug"}
    }
    process {
        
    }
    
    end {
        
    }
}