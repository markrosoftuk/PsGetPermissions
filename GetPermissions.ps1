param(
    [Parameter(Mandatory=$true)]
    [string]$folderPath,
    [int]$levels = -1,
    [switch]$noBuiltIn,
    [switch]$showAll
)

$outputFilePath = Join-Path -Path $PSScriptRoot -ChildPath "folderpermissions.csv"
$permissionsToCheck = 'FullControl', 'ReadAndExecute'
$lastPath = ""

function Get-FolderPermissions {
    param(
        [Parameter(Mandatory=$true)]
        [string]$path,
        [int]$depth = $levels
    )

    $acl = Get-Acl -Path $path
    foreach ($access in $acl.Access) {
        if ((($noBuiltIn -and $access.IdentityReference -notin 'BUILTIN\Administrators', 'NT AUTHORITY\SYSTEM', 'CREATOR OWNER') -or
            (!$noBuiltIn)) -and 
            (($showAll -or $access.FileSystemRights -in $permissionsToCheck))) {
            $folderPath = $path
            if ($folderPath -eq $script:lastPath) {
                $folderPath = ""
            }
            else {
                $script:lastPath = $folderPath
            }
            $obj = New-Object -TypeName PSObject
            $obj | Add-Member -MemberType NoteProperty -Name 'Folder' -Value $folderPath
            $obj | Add-Member -MemberType NoteProperty -Name 'User' -Value $access.IdentityReference
            $obj | Add-Member -MemberType NoteProperty -Name 'Permissions' -Value $access.FileSystemRights
            $obj | Export-Csv -Path $outputFilePath -NoTypeInformation -Append
        }
    }
    
    if ($depth -ne 0) {
        Get-ChildItem -Path $path -Directory | ForEach-Object {
            Get-FolderPermissions -path $_.FullName -depth ($depth - 1)
        }
    }
}

Get-FolderPermissions -path $folderPath
