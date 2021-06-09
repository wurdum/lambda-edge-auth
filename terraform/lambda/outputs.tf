output "ecr_repository_name" {
  value = aws_ecr_repository._.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository._.repository_url
}
