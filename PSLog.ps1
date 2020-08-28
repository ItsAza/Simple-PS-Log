Import-Module .\PSLog\PSLog.psm1 -Force



Remove-Log

Write-Log -msg "This is a Test Info with Source" -i -s
Write-Log -msg "This is a Test" -w 
Write-Log -msg "This is a Test Error with Source" -e -s
Write-Log -msg "This is a Test" -d