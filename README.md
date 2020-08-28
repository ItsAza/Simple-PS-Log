# Simple-PS-Log
 A Simple yet configurable 'Drop in' logging module for PowerShell Scripts.
<br>
<br>

# The Cmdlets:
## Write-Log:
Writes a message to the log file location relative to the Calling Script.  
<br>
### Usage
```ps1
Write-Log -msg "My Message" -i / -w / -e / -d -s
```
### Parameters
| Parameter | Type | Description | Usage |
| ----------- | ----------- | ----------- | ----------- |
| `-msg`  | String | Message to be logged. | `Write-Log -msg "Hello, World!"` |
| `-i`  | Switch | (Default) Designates the message as Info | `Write-Log -msg "Its good to stay informed" -i` |
| `-w`  | Switch | Designates the message as a Warning | `Write-Log -msg "I'm warning you, Buddy.." -w` |
| `-e`  | Switch | Designates the message as an Error | `Write-Log -msg "Something broke :(" -e` |
| `-d`  | Switch | Designates the message as an Debug Message | `Write-Log -msg "Did this code work?" -d` |
| `-s`  | Switch | Logs the source of the Write-Log Call in the message | `Write-Log -msg "The Proof is in the source"  -i -s` |

### Example Output
```log
PSLog-8272020.log
[8272020 - 7:35:30 PM - Info] Its good to stay informed
[8272020 - 7:35:30 PM - Warn] I'm warning you, Buddy..
[8272020 - 7:35:30 PM - Error] Something broke :(
[8272020 - 7:35:30 PM - Debug] Did this code work?
[8272020 - 7:35:30 PM - Info] >> [PSLog.ps1: line 11] The Proof is in the source
```

## Remove-Log
Removes the relevant log file for the script.
<br>
### Usage
```ps1
Remove-Log
```
### Example Output
```
```
# Configuration
### Coming Soon....