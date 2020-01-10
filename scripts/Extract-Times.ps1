param ($since)

If ($since) {
  $sinceAsDate = Get-Date $since
} else {
  $sinceAsDate = (Get-Date).AddDays(-8)
}

((Get-EventLog -LogName system) + (Get-EventLog -LogName security)) |
    Where-Object {$_.Source -eq "Microsoft-Windows-Security-Auditing" -and ($_.InstanceId -eq 4800 -or $_.InstanceId -eq 4801) -and ($_.TimeGenerated -gt $sinceAsDate) } |
    Sort-Object -Property TimeGenerated |
    %{ "{0}`t{1}" -f $_.TimeGenerated.ToString("yyyy-MM-dd HH:mm"), $(If ($_.InstanceId -eq 4800) { 'locked' } Else { 'unlocked' })}

(Get-Date).ToString("yyyy-MM-dd HH:mm") + "`tlocked"

