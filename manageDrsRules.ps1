$vcFQDN = "vcenter-3.vcf-s1.vlabs.local"
$vcUser = "administrator@vsphere.local"
$vcPassword = "VMware1!"
$drsAffinityRulesFile = ".\" + $vcFQDN + "_drsAffinityRules.csv"
$drsVMHostRulesFile = ".\" + $vcFQDN + "_drsVMHostRules.csv"
$clusterName = "s1-cl01"

Connect-VIServer $vcFQDN -username $vcUser -password $vcPassword

$cluster = Get-Cluster -Name $clusterName

# Check for DRS VM affinity/anti-affinity rules
$drsAffinityRules = Get-DrsRule -Cluster $cluster
if ($drsAffinityRules) {
    Write-Host "Found DRS vm affinity rules, proceeding with exporting and disabling..."
    # Export all the existing rules to CSV so we have a snapshot of all rules before making any change
    $drsAffinityRules | Export-Csv $drsAffinityRulesFile
    # disabling all the DRS VM affinity/anti-affinity rules
    $drsAffinityRules | Set-DrsRule -Enabled $false
}
else { Write-Host "No DRS vm affinity rules found!" }

# Check for DRS VM host rules
$drsVMHostRules = Get-DrsVMHostRule -Cluster $cluster
if ($drsVMHostRules) {
    Write-Host "Found DRS vm host rules, proceeding with exporting and disabling..."    
    # Export all the existing rules to CSV so we have a snapshot of all rules before making any change
    $drsVMHostRules | Export-Csv $drsVMHostRulesFile
    # disabling all DRS VM Host rules
    $drsVMHostRules | Set-DrsVMHostRule -Enabled $false
}
else { Write-Host "No DRS vm host rules found!" }

