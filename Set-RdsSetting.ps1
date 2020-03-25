<#

  .SYNOPSIS

  Gets users from a CSV File and clears the checkbox of the "Deny this user permissions to log on to Remote Desktop Session Host server" setting.

  .DESCRIPTION

  Gets users from a CSV File generated from the RDPSetting Script and clears the checkbox of the "Deny this user permissions to log on to Remote Desktop Session Host server" setting.
  1 means allowed (Box is cleared)
  0 Means Deny (Box is Checked)

  .PARAMETER

  -Region EMEA,APAC,AMRS

  .EXAMPLE

  SetRDPSetting.ps1 -Region EMEA

  .INPUTS

  Regions_DeniedUsers.csv

  .OUTPUTS

  .NOTES

  Author:        Patrick Horne

  Creation Date: 19/03/20

  Requires:      ActiveDirectory Module

  Change Log:

  V1.0:         Initial Development

#>

#Requires -Modules ActiveDirectory

param (
    [Parameter(Mandatory)]
    [ValidateSet('EMEA','APAC','AMRS')]
    [String]$Region

)

$SuccessCount = 0
$FailedCount = 0
$ResultsFile = $region + "_User_Results.txt"
$ErrorLog = "Errors.txt"
$DeniedUsersFile = $region + "_DeniedUsers.csv"
$Users = Import-CSV $DeniedUsersFile

Foreach ($user in $Users) {
    Try {
        $UserDN = $User.DistinguishedName
        $TheUser = [ADSI]"LDAP://$UserDN"
        $TheUser.SamAccountName #to check the account
        $TheUser.psbase.invokeSet("allowLogon", 1)
        $TheUser.setinfo()
        $SuccessCount++

}

    Catch {
        $TheUser.distinguishedName | Out-File $ErrorLog -Append
        $_.Exception.message | Out-File $ErrorLog -Append
        $FailedCount++

}

}

"$SuccessCount Successful Users"| Out-File $ResultsFile -Append
"$FailedCount failed Users"| Out-File $ResultsFile -Append 