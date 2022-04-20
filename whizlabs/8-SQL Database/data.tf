data "http" "myip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  my_ip_json = jsondecode(data.http.myip.body)
}