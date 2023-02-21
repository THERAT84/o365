<#########################################################################
    script name:    export-mailboxes-incl.archive.ps1
    function:       export all user mailboxes from exchange to a pst file
    date:           21.02.2023
    author:         therat84
    version:        1.0
    changes:
#########################################################################>

# variables
$exportPath = "\\192.168.100.11\tempPST\"
$exportarchive = "\\192.168.100.11\tempArchive\"

<# already manually done
    # variables
    $domain = "contoso.local"
    $adminUser = "admin"
    $exchangeRole = 'Mailbox Import Export'

    # assign Role for export
    Write-Host "Assign Import/Export Role for User $adminUser..."
    New-ManagementRoleAssignment â€“Role $exchangeRole â€“User $domain\$adminUser
#>

# export PST for every user
(Get-Mailbox) | foreach {
    New-MailboxExportRequest -Mailbox $_.alias -FilePath "$exportPath\$_.pst" -Name $_.alias
}

# export Archive for every user
(Get-Mailbox) | foreach {
    New-MailboxExportRequest -Mailbox $_.alias -IsArchive -FilePath "$exportarchive\$_.pst" -Name $_.alias.archive
}