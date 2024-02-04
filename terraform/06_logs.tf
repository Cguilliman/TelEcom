resource "aws_cloudwatch_log_group" "telecom-api-group" {
  name              = "/ecs/telecom-api"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "telecom-api-stream" {
  name           = "telecom-api-log-stream"
  log_group_name = aws_cloudwatch_log_group.telecom-api-group.name
}

# resource "aws_cloudwatch_log_group" "telecom-api-group" {
#   name              = "/ecs/telecom-api-migrations"
#   retention_in_days = var.log_retention_in_days
# }

# resource "aws_cloudwatch_log_stream" "telecom-api-stream" {
#   name           = "telecom-api-log-stream-migrations"
#   log_group_name = aws_cloudwatch_log_group.telecom-api-group.name
# }

resource "aws_cloudwatch_log_group" "nginx-log-group" {
  name              = "/ecs/nginx"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "nginx-log-stream" {
  name           = "nginx-log-stream"
  log_group_name = aws_cloudwatch_log_group.nginx-log-group.name
}
