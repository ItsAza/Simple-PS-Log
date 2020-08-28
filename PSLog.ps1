Import-Module .\PSLog.psm1 -Force



Remove-Log

Write-Log -msg "Its good to stay informed" -i
Write-Log -msg "I'm warning you, Buddy.." -w
Write-Log -msg "Something broke :(" -e
Write-Log -msg "Did this code work?" -d
Write-Log -msg "The Proof is in the source"  -i -s