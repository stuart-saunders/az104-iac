locals {  
  my_ip = jsondecode(data.http.my_ip.body).ip
}