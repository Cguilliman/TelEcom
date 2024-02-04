[
  {
    "name": "${name}",
    "image": "${docker_image_url_telecom_api}",
    "essential": true,
    "cpu": 10,
    "memory": 512,
    "links": [],
    "portMappings": [
      {
        "containerPort": 8000,
        "hostPort": 0,
        "protocol": "tcp"
      }
    ],
    "command": ${jsonencode(command)},
    "environment": [
      {
        "name": "DATABASE_NAME",
        "value": "${rds_db_name}"
      },
      {
        "name": "DATABASE_USER",
        "value": "${rds_username}"
      },
      {
        "name": "DATABASE_PASSWORD",
        "value": "${rds_password}"
      },
      {
        "name": "DATABASE_HOST",
        "value": "${rds_hostname}"
      },
      {
        "name": "DATABASE_PORT",
        "value": "5432"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/telecom-api",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${log_stream}"
      }
    }
  }
]