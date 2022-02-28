output "DNS" {
  value = aws_eip.app-eip.*.public_dns
}

output "IP" {
  value = aws_eip.app-eip.*.public_ip
}
