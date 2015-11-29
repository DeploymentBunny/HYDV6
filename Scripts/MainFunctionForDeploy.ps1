    <#
    .Synopsis
        Main function for Deployment HYDv6
    .DESCRIPTION
        Main function for Deployment HYDv6
    .EXAMPLE
        Import-Module MainFunction.ps1
    .Created
        2015-11-29
    .VERSION
        1.0
    .Author
        Name        Mikael Nystrom
        Twitter     @mikael_nystrom
        Blog        http://www.deploymentbunny.com
    .Disclaimer
        This script is provided "AS IS" with no warranties, confers no rights and is not supported by the author. 
    #>
Function Install-FARoles{
    <#
    .Synopsis
        Script for HYDv6
    .DESCRIPTION
        Script for HYDv6
    .EXAMPLE
        Install-FARoles -Role FILE
    .Created
        205-11-29
    .VERSION
        1.2
    .Author
        Name        Mikael Nystrom
        Twitter     @mikael_nystrom
        Blog        http://www.deploymentbunny.com
    .Disclaimer
        This script is provided "AS IS" with no warranties, confers no rights and is not supported by the author. 
    #>
    [cmdletbinding(SupportsShouldProcess=$True)]
    Param
    (
        [parameter(mandatory=$True,ValueFromPipelineByPropertyName=$true,Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Default","FILE","RDGW","ADDS","DHCP","RRAS","RDGW","MGMT","DEPL","ADCA","WSUS","SCVM","SCOR","HYPERV")]
        $Role
    )
    Write-Output "Role selected is: $Role"
    switch ($Role)
    {
        HYPERV
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "FS-Data-Deduplication",
            "Hyper-V",  
            "Hyper-V-Tools",
            "Hyper-V-PowerShell"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools -IncludeAllSubFeature -ErrorAction Stop
        }
        FILE
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "FileAndStorage-Services",
            "File-Services",
            "FS-FileServer",
            "FS-Data-Deduplication"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools -IncludeAllSubFeature -ErrorAction Stop
        }
        RDGW
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "RDS-GateWay"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools -IncludeAllSubFeature -ErrorAction Stop
        }
        ADDS
        {
            Write-Output "Adding Windows Features for $Role"
            Add-WindowsFeature -Name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
            Enable-WindowsOptionalFeature -FeatureName WindowsServerBackup -Online -NoRestart -All
        }
        DHCP
        {
            Write-Output "Adding Windows Features for $Role"
            Add-WindowsFeature -Name DHCP -IncludeManagementTools
            Start-Sleep 2
        }
        RRAS
        {
            Write-Output "Adding Windows Features for $Role"
            Install-WindowsFeature Routing -IncludeManagementTools
            Install-RemoteAccess -VpnType Vpn
        }
        RDGW
        {
            Write-Output "Adding Windows Features for $Role"
            Install-WindowsFeature -Name RDS-GateWay -IncludeManagementTools -IncludeAllSubFeature
        }
        MGMT
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "RDS-RD-Server",
            "Web-Metabase",
            "Web-Lgcy-Mgmt-Console",
            "NET-WCF-TCP-PortSharing45",
            "GPMC",
            "InkAndHandwritingServices",
            "Server-Media-Foundation",
            "CMAK",
            "RSAT-SMTP",
            "RSAT-Feature-Tools-BitLocker",
            "RSAT-Bits-Server",
            "RSAT-Clustering-Mgmt",
            "RSAT-Clustering-PowerShell",
            "RSAT-NLB",
            "RSAT-SNMP",
            "RSAT-AD-PowerShell",
            "RSAT-AD-AdminCenter",
            "RSAT-ADDS-Tools",
            "Hyper-V-Tools",
            "Hyper-V-PowerShell",
            "RSAT-RDS-Licensing-Diagnosis-UI",
            "UpdateServices-API",
            "UpdateServices-UI",
            "RSAT-ADCS-Mgmt",
            "RSAT-Online-Responder",
            "RSAT-DHCP",
            "RSAT-DNS-Server",
            "RSAT-DFS-Mgmt-Con",
            "RSAT-FSRM-Mgmt",
            "RSAT-NFS-Admin",
            "RSAT-CoreFile-Mgmt",
            "RSAT-RemoteAccess-Mgmt",
            "RSAT-RemoteAccess-PowerShell",
            "RSAT-VA-Tools",
            "WDS-AdminPack",
            "Telnet-Client",
            "Desktop-Experience",
            "XPS-Viewer",
            "VolumeActivation"
            )
            Install-WindowsFeature -Name $ServicesToInstall
        }
        DEPL
        {
            Write-Output "Adding Windows Features for $Role"
            Add-WindowsFeature -Name WDS -IncludeAllSubFeature -IncludeManagementTools
            Add-WindowsFeature -Name FS-FileServer,FS-Data-Deduplication
        }
        ADCA
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "ADCS-Cert-Authority"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools
        }
        WSUS
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "UpdateServices-Services",
            "UpdateServices-DB"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools
        }
        SCVM
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "Hyper-V-Tools",
            "Hyper-V-PowerShell",
            "UpdateServices-API",
            "UpdateServices-UI"
            "UpdateServices-RSAT",
            "RSAT-Clustering",
            "RSAT-AD-Tools",
            "RSAT-DHCP",
            "RSAT-DNS-Server",
            "WDS-AdminPack"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools
        }
        SCOR
        {
            Write-Output "Adding Windows Features for $Role"
            $ServicesToInstall = @(
            "Web-Common-Http",
            "Web-Static-Content",
            "Web-Default-Doc",
            "Web-Dir-Browsing",
            "Web-Http-Errors",
            "Web-Http-Logging",
            "Web-Request-Monitor",
            "Web-Stat-Compression"
            )
            Install-WindowsFeature -Name $ServicesToInstall -IncludeManagementTools
        }
        Default
        {
            Write-Warning "Nothing to do for role $Role"
        }
    }
}