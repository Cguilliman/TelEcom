resource "aws_ecs_cluster" "production" {
  name = "${var.ecs_cluster_name}-cluster"
}

resource "aws_launch_configuration" "ecs" {
  name                        = "${var.ecs_cluster_name}-cluster"
  image_id                    = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ecs.id]
  iam_instance_profile        = aws_iam_instance_profile.ecs.name
  # key_name                    = "telecom_api_pair"
  key_name                    = aws_key_pair.telecom_key_pair.key_name
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}-cluster' > /etc/ecs/ecs.config"
}

resource "aws_ecs_task_definition" "app" {
  family                = "telecom-api"
  depends_on            = [aws_db_instance.production]

  volume {
    name      = "static_volume"
    host_path = "/src/staticfiles/"
  }

  container_definitions = templatefile(
    "templates/telecom_api.json.tpl",
    {
      name                         = "telecom-api"
      command                      = ["gunicorn", "-w", "3", "-b", ":8000", "app.wsgi:application"]
      docker_image_url_telecom_api = var.docker_image_url_telecom_api
      docker_image_url_nginx       = var.docker_image_url_nginx
      region                       = var.region
      rds_db_name                  = var.rds_db_name
      rds_username                 = var.rds_username
      rds_password                 = var.rds_password
      rds_hostname                 = aws_db_instance.production.address
      log_stream                   = "telecom-api-log-stream"
      allowed_hosts                = var.allowed_hosts
    }
  )
}

resource "aws_ecs_service" "production" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.production.id
  task_definition = aws_ecs_task_definition.app.arn
  iam_role        = aws_iam_role.ecs-service-role.arn
  desired_count   = var.app_count
  depends_on      = [aws_alb_listener.ecs-alb-http-listener, aws_iam_role_policy.ecs-service-role-policy]

  load_balancer {
    target_group_arn = aws_alb_target_group.default-target-group.arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "app_migrations" {
  family                = "telecom-api-migration"
  depends_on            = [aws_db_instance.production]
  container_definitions = templatefile(
    "templates/telecom_api_migrations.json.tpl",
    {
      name                         = "telecom-api-migrations"
      command                      = ["python", "manage.py", "migrate"]
      docker_image_url_telecom_api = var.docker_image_url_telecom_api
      docker_image_url_nginx       = var.docker_image_url_nginx
      region                       = var.region
      rds_db_name                  = var.rds_db_name
      rds_username                 = var.rds_username
      rds_password                 = var.rds_password
      rds_hostname                 = aws_db_instance.production.address
      log_stream                   = "telecom-api-log-stream"
    }
  )
}
