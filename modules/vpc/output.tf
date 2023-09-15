output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = tolist(values(aws_subnet.public_subnet)[*].id)
}

output "private_subnets" {
  value = tolist(values(aws_subnet.private_subnet)[*].id)
}

