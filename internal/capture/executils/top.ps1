$LogicalProcessors = (Get-WmiObject -class Win32_processor -Property NumberOfLogicalProcessors).NumberOfLogicalProcessors;
$SortCol = "CPU"
$Top = 10000
$totalMemory = (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory
if (
  ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
  ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
)
{
  $procTbl = get-process -IncludeUserName | select ID, Name, UserName, Description, MainWindowTitle
} else {
  $procTbl = get-process | select ID, Name, Description, MainWindowTitle
}

Get-Counter `
  '\Process(*)\ID Process',`
  '\Process(*)\% Processor Time',`
  '\Process(*)\Working Set - Private'`
  -ea SilentlyContinue |
foreach CounterSamples |
where InstanceName -notin "_total","memory compression" |
group { $_.Path.Split("\\")[3] } |
foreach {
  $procIndex = [array]::indexof($procTbl.ID, [Int32]$_.Group[0].CookedValue)
  [pscustomobject]@{
    Name = $_.Group[0].InstanceName;
    ID = $_.Group[0].CookedValue;
    User = $procTbl.UserName[$procIndex]
    CPU = if($_.Group[0].InstanceName -eq "idle") {
      $_.Group[1].CookedValue / $LogicalProcessors
      } else {
      $_.Group[1].CookedValue
    };
	Memory = $_.Group[2].CookedValue / 1KB;
    MemoryPercentage = (($_.Group[2].CookedValue / $totalMemory) * 100);
  }
} |
sort -des $SortCol |
select -f $Top @(
  "Name", "ID", "User",
  @{ n = "CPU"; e = { ("{0:N1}%" -f $_.CPU) } },
  @{ n = "Memory"; e = { ("{0:N0} K" -f $_.Memory) } },
  @{ n = "Mem"; e = { ("{0:N1}%" -f $_.MemoryPercentage) } }
) | ft -a
