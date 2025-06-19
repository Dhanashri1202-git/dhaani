output "instance_public_ip" {
  description = "The public IP of the Strapi EC2 instance"
  value       = aws_instance.strapi_ec2.public_ip
}
