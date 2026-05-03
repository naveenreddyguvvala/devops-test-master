output "ecs_cluster" {
  value = aws_ecs_cluster.cluster.id
}

output "ecs_sg" {
  value = aws_security_group.ecs_sg.id
}
