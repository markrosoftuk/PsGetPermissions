
# PowerShell Folder Permissions Script

This PowerShell script is designed to report the permissions of a specified directory and its subdirectories. It has options to control how deep into the directory tree to go, whether to exclude permissions for built-in users such as 'BUILTIN\Administrators', 'NT AUTHORITY\SYSTEM', and 'CREATOR OWNER', and whether to show all permissions or only 'FullControl' and 'ReadAndExecute'.

## Usage

The script takes the following parameters:

- `folderPath` (mandatory): The path to the directory for which to report permissions.
- `levels`: The maximum depth of subdirectories to include in the report. If not specified, the script will traverse all subdirectories regardless of their depth.
- `noBuiltIn`: A switch parameter. If specified, the script will not include permissions for 'BUILTIN\Administrators', 'NT AUTHORITY\SYSTEM', and 'CREATOR OWNER'.
- `showAll`: A switch parameter. If specified, the script will include all types of permissions, not just 'FullControl' and 'ReadAndExecute'.

The script writes its output to a CSV file named `folderpermissions.csv` in the same directory as the script. The CSV file has columns for 'Folder', 'User', and 'Permissions'.

### Examples

To report 'FullControl' and 'ReadAndExecute' permissions for a directory and all of its subdirectories, regardless of depth:

```powershell
.\GetPermissions.ps1 -folderPath "C:\path_to_folder"
```

To report 'FullControl' and 'ReadAndExecute' permissions for a directory and its subdirectories up to 2 levels deep:

```powershell
.\GetPermissions.ps1 -folderPath "C:\path_to_folder" -levels 2
```

To report 'FullControl' and 'ReadAndExecute' permissions for a directory and all of its subdirectories, excluding permissions for built-in users:

```powershell
.\GetPermissions.ps1 -folderPath "C:\path_to_folder" -noBuiltIn
```

To report all types of permissions for a directory and all of its subdirectories:

```powershell
.\GetPermissions.ps1 -folderPath "C:\path_to_folder" -showAll
```

To report all types of permissions for a directory and its subdirectories up to 2 levels deep, excluding permissions for built-in users:

```powershell
.\GetPermissions.ps1 -folderPath "C:\path_to_folder" -levels 2 -noBuiltIn -showAll
```
