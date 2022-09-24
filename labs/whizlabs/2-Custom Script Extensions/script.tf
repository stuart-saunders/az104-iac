resource "local_file" "script" {
    content  = "apt-get update -y && apt-get upgrade -y && apt-get install -y nginx"
    filename = var.script_filename
}