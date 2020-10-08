$vcFQDN = "vcenter-3.vcf-s1.vlabs.local"
$vcUser = "administrator@vsphere.local"
$vcPassword = "VMware1!"
$vmAffinityRulesFile = ".\" + $vcFQDN + "_vmAffinityRules.csv"
$drsVMHostRulesFile = ".\" + $vcFQDN + "_drsVMHostRules.csv"
$clusterName = "s1-cl01"

Connect-VIServer $vcFQDN -username $vcUser -password $vcPassword

$cluster = Get-Cluster -Name $clusterName

# Check for DRS VM affinity/anti-affinity rules
$vmAffinityRules = Get-DrsRule -Cluster $cluster
if ($vmAffinityRules) {

    $vmAffinityRules | Export-Csv $vmAffinityRulesFile
    $vmAffinityRules | Set-DrsRule -Enabled $false
}

# Check for DRS VM host rules
$vmHostRules = Get-DrsVMHostRule -Cluster $cluster
if ($vmHostRules) {

    $vmHostRules | Export-Csv $drsVMHostRulesFile
    $vmHostRules | Set-DrsVMHostRule -Enabled $false

}

