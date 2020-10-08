$vcFQDN = "vcenter-3.vcf-s1.vlabs.local"
$vcUser = "administrator@vsphere.local"
$vcPassword = "VMware1!"
$vmAffinityRulesFile = ".\" + $vcFQDN + "_vmAffinityRules.csv"
$drsVMHostRules = ".\" + $vcFQDN + "_
drsVMHostRules.csv"
$clusterName = "s1-cl01"

Connect-VIServer $vcFQDN -username $vcUser -password $vcPassword

$cluster = Get-Cluster -Name $clusterName

# Check for VM affinity/anti-affinity rules
$vmAffinityRules = Get-DrsRule -Cluster $cluster

if ($vmAffinityRules) {
    $vmAffinityRules | Export-Csv $vmAffinityRulesFile
    $vmAffinityRules | Set-DrsRule -Enabled $false
}

#Get-DrsVMHostRule -Cluster $cluster | Set-DrsVMHostRule -Enabled $false