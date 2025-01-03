#Add Consul UI URL
output "hello_service_url" {
  value = "curl  http://${aws_instance.hello_service.public_ip}:5050/hello | jq"
}

output "response_service_url" {
    value = <<CONFIGURATION
    curl http://${aws_instance.response_service[0].public_ip}:6060/response | jq
    curl http://${aws_instance.response_service[1].public_ip}:6060/response | jq
    CONFIGURATION
}

output "instance_ids" {
    value = <<CONFIGURATION
    ${aws_instance.response_service[0].id},
    ${aws_instance.response_service[1].id}
    CONFIGURATION
}

output "ssh_to_hello_service" {
    value = <<CONFIGURATION
    ssh -i "minion-key.pem" ubuntu@${aws_instance.hello_service.public_ip}
    CONFIGURATION
}

output "ssh_to_response_service" {
    value = <<CONFIGURATION
    ssh -i "minion-key.pem" ubuntu@${aws_instance.response_service[0].public_ip}
    ssh -i "minion-key.pem" ubuntu@${aws_instance.response_service[1].public_ip}
    CONFIGURATION
}

output "consul_ui_url" {
  value = "http://${aws_instance.consul.public_ip}:8500"
}

output "env" {
    value = <<CONFIGURATION
    export HELLO_SERVICE=${aws_instance.hello_service.public_ip}
    export RESPONSE_SERVICE_0=${aws_instance.response_service[0].public_ip}
    export RESPONSE_SERVICE_1=${aws_instance.response_service[1].public_ip}
    CONFIGURATION  
}

