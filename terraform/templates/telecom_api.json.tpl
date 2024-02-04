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
      },
      {
        "name": "ALLOWED_HOSTS",
        "value": "${allowed_hosts}"
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/src/staticfiles",
        "sourceVolume": "static_volume"
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
  },
  {
    "name": "nginx",
    "image": "${docker_image_url_nginx}",
    "essential": true,
    "cpu": 10,
    "memory": 128,
    "links": ["telecom-api"],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 0,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/src/staticfiles",
        "sourceVolume": "static_volume"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/nginx",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "nginx-log-stream"
      }
    }
  },
  {
    "name": "collectstatic",
    "image": "${docker_image_url_telecom_api}",
    "essential": false,
    "cpu": 10,
    "memory": 128,
    "links": [],
    "command": ["python", "manage.py", "collectstatic", "--no-input"],
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
    "mountPoints": [
      {
        "containerPath": "/src/staticfiles",
        "sourceVolume": "static_volume"
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
  },
  {
    "name": "run-migrations",
    "image": "${docker_image_url_telecom_api}",
    "essential": false,
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
    "command": ["python", "manage.py", "migrate"],
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