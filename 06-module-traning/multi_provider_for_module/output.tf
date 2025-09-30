output "module_output_california" {
  value = module.ec2_california.private_ip
}
output "module_output_seoul" {
  value = module.ec2_seoul.private_ip
}