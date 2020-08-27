function Get-Setting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True,HelpMessage="Setting to retrieve the value of.")] 
        [string]$Filter   
    )
    begin {
        $returnValue = $null
        [xml]$xml_Build = Get-Content ".\bin\PSLog.p"
    }
    process {
        foreach ($Setting in $xml_Build.xml.Build.setting)
        {
            if($Setting.name -eq $Filter)
            {
                $returnValue = $Setting.value
            }
        }
    }
    end {return $returnValue;}
}