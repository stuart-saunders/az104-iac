# resource "local_file" "script" {
#     content  = <<CONTENT
# Get-Disk ^|
# Where-Object PartitionStyle -eq 'raw' ^|
# Initialize-Disk -PartitionStyle MBR -PassThru ^|
# New-Partition -AssignDriveLetter -UseMaximumSize ^|
# Format-Volume -FileSystem NTFS -NewFileSystemLabel 'disk2' -Confirm:$false
#     CONTENT
#     filename = var.script_filename
# }

resource "local_file" "script" {
    content  = "Get-Disk ^| Where-Object PartitionStyle -eq 'raw' ^| Initialize-Disk -PartitionStyle MBR -PassThru ^| New-Partition -AssignDriveLetter -UseMaximumSize ^| Format-Volume -FileSystem NTFS -NewFileSystemLabel 'disk2' -Confirm:$false"
    filename = var.script_filename
}