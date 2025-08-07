# 📋 Task 3: Execution Logs Guide

## 🎯 How to Capture Execution Logs

### **Step 1: Initialize Terraform**
```bash
cd task-3
terraform init
```

**Expected Log Output:**
```
$ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "~> 3.0"...
- Installing kreuzwerker/docker v3.6.2...
- Installed kreuzwerker/docker v3.6.2 (self-signed, key ID BD080C4571C6104C)
Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://developer.hashicorp.com/terraform/cli/plugins/signing
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### **Step 2: Plan the Infrastructure**
```bash
terraform plan
```

**Expected Log Output:**
```
 terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated 
with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.database will be created
  + resource "docker_container" "database" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (sensitive value)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "task3-database"
      + network_data                                = (known after apply)
      + network_mode                                = "bridge"
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "unless-stopped"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck {
          + interval       = "30s"
          + retries        = 3
          + start_interval = "0s"
          + start_period   = "40s"
          + test           = [
              + "CMD",
              + "mysqladmin",
              + "ping",
              + "-h",
              + "localhost",
            ]
          + timeout        = "10s"
        }

      + labels (known after apply)

      + networks_advanced {
          + aliases      = []
          + name         = "task3-network"
            # (2 unchanged attributes hidden)
        }

      + volumes {
          + container_path = "/var/lib/mysql"
          + volume_name    = "task3-data"
            # (2 unchanged attributes hidden)
        }
    }

  # docker_container.web_app will be created
  + resource "docker_container" "web_app" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = [
          + "NODE_ENV=production",
          + "PORT=80",
        ]
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "task3-web-app"
      + network_data                                = (known after apply)
      + network_mode                                = "bridge"
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "unless-stopped"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck {
          + interval       = "30s"
          + retries        = 3
          + start_interval = "0s"
          + start_period   = "40s"
          + test           = [
              + "CMD",
              + "curl",
              + "-f",
              + "http://localhost:80/health",
            ]
          + timeout        = "10s"
        }

      + labels (known after apply)

      + networks_advanced {
          + aliases      = []
          + name         = "task3-network"
            # (2 unchanged attributes hidden)
        }

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }

      + volumes {
          + container_path = "/app/data"
          + volume_name    = "task3-data"
            # (2 unchanged attributes hidden)
        }
    }

  # docker_image.database will be created
  + resource "docker_image" "database" {
      + id          = (known after apply)
      + image_id    = (known after apply)
      + name        = "mysql:8.0"
      + repo_digest = (known after apply)
    }

  # docker_image.web_app will be created
  + resource "docker_image" "web_app" {
      + id          = (known after apply)
      + image_id    = (known after apply)
      + name        = "task3-custom-nginx:latest"
      + repo_digest = (known after apply)

      + build {
          + cache_from     = []
          + context        = "./custom-nginx"
          + dockerfile     = "Dockerfile"
          + extra_hosts    = []
          + remove         = true
          + security_opt   = []
          + tag            = []
            # (13 unchanged attributes hidden)
        }
    }

  # docker_network.task3_network will be created
  + resource "docker_network" "task3_network" {
      + driver      = "bridge"
      + id          = (known after apply)
      + internal    = (known after apply)
      + ipam_driver = "default"
      + name        = "task3-network"
      + options     = (known after apply)
      + scope       = (known after apply)

      + ipam_config (known after apply)
    }

  # docker_volume.task3_volume will be created
  + resource "docker_volume" "task3_volume" {
      + driver     = (known after apply)
      + id         = (known after apply)
      + mountpoint = (known after apply)
      + name       = "task3-data"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + access_urls            = (sensitive value)
  + database_info          = {
      + image      = "mysql:8.0"
      + ip_address = (known after apply)
      + name       = "task3-database"
    }
  + infrastructure_summary = {
      + containers_created = 2
      + images_used        = [
          + "task3-custom-nginx:latest",
          + "mysql:8.0",
        ]
      + networks_created   = 1
      + total_resources    = 5
      + volumes_created    = 1
    }
  + network_info           = {
      + driver = "bridge"
      + name   = "task3-network"
    }
  + volume_info            = {
      + name = "task3-data"
    }
  + web_app_info           = {
      + external_port = 8080
      + image         = "task3-custom-nginx:latest"
      + ip_address    = (known after apply)
      + name          = "task3-web-app"
    }

────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these     
actions if you run "terraform apply" now.
```
### **Step 3: Apply the Infrastructure**
```bash
terraform apply --auto-approve
```

**Expected Log Output:**
```

```

### **Step 6: Destroy Infrastructure**
```bash
terraform destroy
```

**Expected Log Output:**
```
$ terraform destroy --auto-approve
docker_volume.task3_volume: Refreshing state... [id=task3-data]
docker_image.database: Refreshing state... [id=sha256:e95435ce9c6b5507dc38ba2bf4da9d8d91d6a5d55045e70c0ffc4befd66b1eaemysql:8.0]
docker_network.task3_network: Refreshing state... [id=7784e8bab8c263e33099aabcb216a5b8adf74a96d4c3b990c1fcf747171b7443]  
docker_image.web_app: Refreshing state... [id=sha256:d4207f969b519c1b6ecc81c0389e867c618e89e633927caebab805417e11abcdtask3-custom-nginx:latest]
docker_container.database: Refreshing state... [id=96039351e0a8c4dc9f6df1fdebf94e66236328bd73aa615ba0bd2f8cd11ace77]
docker_container.web_app: Refreshing state... [id=10e4c7791462a10cd9d405e9fb6f893a4737affd5f44c2ba4ed3e594fe418261]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the  
following symbols:
  - destroy

Terraform will perform the following actions:

  # docker_container.database will be destroyed
  - resource "docker_container" "database" {
      - attach                                      = false -> null
      - command                                     = [
          - "mysqld",
        ] -> null
      - container_read_refresh_timeout_milliseconds = 15000 -> null
      - cpu_shares                                  = 0 -> null
      - dns                                         = [] -> null
      - dns_opts                                    = [] -> null
      - dns_search                                  = [] -> null
      - entrypoint                                  = [
          - "docker-entrypoint.sh",
        ] -> null
      - env                                         = (sensitive value) -> null
      - group_add                                   = [] -> null
      - hostname                                    = "96039351e0a8" -> null
      - id                                          = "96039351e0a8c4dc9f6df1fdebf94e66236328bd73aa615ba0bd2f8cd11ace77" -> null
      - image                                       = "sha256:e95435ce9c6b5507dc38ba2bf4da9d8d91d6a5d55045e70c0ffc4befd66b1eae" -> null
      - init                                        = false -> null
      - ipc_mode                                    = "private" -> null
      - log_driver                                  = "json-file" -> null
      - log_opts                                    = {} -> null
      - logs                                        = false -> null
      - max_retry_count                             = 0 -> null
      - memory                                      = 0 -> null
      - memory_swap                                 = 0 -> null
      - must_run                                    = true -> null
      - name                                        = "task3-database" -> null
      - network_data                                = [
          - {
              - gateway                   = "172.19.0.1"
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.19.0.3"
              - ip_prefix_length          = 16
              - mac_address               = "5a:af:07:50:1b:dd"
              - network_name              = "task3-network"
                # (2 unchanged attributes hidden)
            },
        ] -> null
      - network_mode                                = "bridge" -> null
      - privileged                                  = false -> null
      - publish_all_ports                           = false -> null
      - read_only                                   = false -> null
      - remove_volumes                              = true -> null
      - restart                                     = "unless-stopped" -> null
      - rm                                          = false -> null
      - runtime                                     = "runc" -> null
      - security_opts                               = [] -> null
      - shm_size                                    = 64 -> null
      - start                                       = true -> null
      - stdin_open                                  = false -> null
      - stop_timeout                                = 0 -> null
      - storage_opts                                = {} -> null
      - sysctls                                     = {} -> null
      - tmpfs                                       = {} -> null
      - tty                                         = false -> null
      - wait                                        = false -> null
      - wait_timeout                                = 60 -> null
      - working_dir                                 = "/" -> null
        # (7 unchanged attributes hidden)

      - healthcheck {
          - interval       = "30s" -> null
          - retries        = 3 -> null
          - start_interval = "0s" -> null
          - start_period   = "40s" -> null
          - test           = [
              - "CMD",
              - "mysqladmin",
              - "ping",
              - "-h",
              - "localhost",
            ] -> null
          - timeout        = "10s" -> null
        }

      - networks_advanced {
          - aliases      = [] -> null
          - name         = "task3-network" -> null
            # (2 unchanged attributes hidden)
        }

      - volumes {
          - container_path = "/var/lib/mysql" -> null
          - read_only      = false -> null
          - volume_name    = "task3-data" -> null
            # (2 unchanged attributes hidden)
        }
    }

  # docker_container.web_app will be destroyed
  - resource "docker_container" "web_app" {
      - attach                                      = false -> null
      - command                                     = [
          - "nginx",
          - "-g",
          - "daemon off;",
        ] -> null
      - container_read_refresh_timeout_milliseconds = 15000 -> null
      - cpu_shares                                  = 0 -> null
      - dns                                         = [] -> null
      - dns_opts                                    = [] -> null
      - dns_search                                  = [] -> null
      - entrypoint                                  = [
          - "/docker-entrypoint.sh",
        ] -> null
      - env                                         = [
          - "NODE_ENV=production",
          - "PORT=80",
        ] -> null
      - group_add                                   = [] -> null
      - hostname                                    = "10e4c7791462" -> null
      - id                                          = "10e4c7791462a10cd9d405e9fb6f893a4737affd5f44c2ba4ed3e594fe418261" -> null
      - image                                       = "sha256:d4207f969b519c1b6ecc81c0389e867c618e89e633927caebab805417e11abcd" -> null
      - init                                        = false -> null
      - ipc_mode                                    = "private" -> null
      - log_driver                                  = "json-file" -> null
      - log_opts                                    = {} -> null
      - logs                                        = false -> null
      - max_retry_count                             = 0 -> null
      - memory                                      = 0 -> null
      - memory_swap                                 = 0 -> null
      - must_run                                    = true -> null
      - name                                        = "task3-web-app" -> null
      - network_data                                = [
          - {
              - gateway                   = "172.19.0.1"
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.19.0.2"
              - ip_prefix_length          = 16
              - mac_address               = "72:16:97:8d:29:0d"
              - network_name              = "task3-network"
                # (2 unchanged attributes hidden)
            },
        ] -> null
      - network_mode                                = "bridge" -> null
      - privileged                                  = false -> null
      - publish_all_ports                           = false -> null
      - read_only                                   = false -> null
      - remove_volumes                              = true -> null
      - restart                                     = "unless-stopped" -> null
      - rm                                          = false -> null
      - runtime                                     = "runc" -> null
      - security_opts                               = [] -> null
      - shm_size                                    = 64 -> null
      - start                                       = true -> null
      - stdin_open                                  = false -> null
      - stop_signal                                 = "SIGQUIT" -> null
      - stop_timeout                                = 0 -> null
      - storage_opts                                = {} -> null
      - sysctls                                     = {} -> null
      - tmpfs                                       = {} -> null
      - tty                                         = false -> null
      - wait                                        = false -> null
      - wait_timeout                                = 60 -> null
      - working_dir                                 = "/" -> null
        # (6 unchanged attributes hidden)

      - healthcheck {
          - interval       = "30s" -> null
          - retries        = 3 -> null
          - start_interval = "0s" -> null
          - start_period   = "40s" -> null
          - test           = [
              - "CMD",
              - "curl",
              - "-f",
              - "http://localhost:80/health",
            ] -> null
          - timeout        = "10s" -> null
        }

      - networks_advanced {
          - aliases      = [] -> null
          - name         = "task3-network" -> null
            # (2 unchanged attributes hidden)
        }

      - ports {
          - external = 8080 -> null
          - internal = 80 -> null
          - ip       = "0.0.0.0" -> null
          - protocol = "tcp" -> null
        }

      - volumes {
          - container_path = "/app/data" -> null
          - read_only      = false -> null
          - volume_name    = "task3-data" -> null
            # (2 unchanged attributes hidden)
        }
    }

  # docker_image.database will be destroyed
  - resource "docker_image" "database" {
      - id          = "sha256:e95435ce9c6b5507dc38ba2bf4da9d8d91d6a5d55045e70c0ffc4befd66b1eaemysql:8.0" -> null
      - image_id    = "sha256:e95435ce9c6b5507dc38ba2bf4da9d8d91d6a5d55045e70c0ffc4befd66b1eae" -> null
      - name        = "mysql:8.0" -> null
      - repo_digest = "mysql@sha256:e95435ce9c6b5507dc38ba2bf4da9d8d91d6a5d55045e70c0ffc4befd66b1eae" -> null
    }

  # docker_image.web_app will be destroyed
  - resource "docker_image" "web_app" {
      - id          = "sha256:d4207f969b519c1b6ecc81c0389e867c618e89e633927caebab805417e11abcdtask3-custom-nginx:latest" -> null
      - image_id    = "sha256:d4207f969b519c1b6ecc81c0389e867c618e89e633927caebab805417e11abcd" -> null
      - name        = "task3-custom-nginx:latest" -> null
      - repo_digest = "task3-custom-nginx@sha256:d4207f969b519c1b6ecc81c0389e867c618e89e633927caebab805417e11abcd" -> null

      - build {
          - build_args      = {} -> null
          - cache_from      = [] -> null
          - context         = "./custom-nginx" -> null
          - cpu_period      = 0 -> null
          - cpu_quota       = 0 -> null
          - cpu_shares      = 0 -> null
          - dockerfile      = "Dockerfile" -> null
          - extra_hosts     = [] -> null
          - force_remove    = false -> null
          - label           = {} -> null
          - labels          = {} -> null
          - memory          = 0 -> null
          - memory_swap     = 0 -> null
          - no_cache        = false -> null
          - pull_parent     = false -> null
          - remove          = true -> null
          - security_opt    = [] -> null
          - shm_size        = 0 -> null
          - squash          = false -> null
          - suppress_output = false -> null
          - tag             = [] -> null
            # (13 unchanged attributes hidden)
        }
    }

  # docker_network.task3_network will be destroyed
  - resource "docker_network" "task3_network" {
      - attachable   = false -> null
      - driver       = "bridge" -> null
      - id           = "7784e8bab8c263e33099aabcb216a5b8adf74a96d4c3b990c1fcf747171b7443" -> null
      - ingress      = false -> null
      - internal     = false -> null
      - ipam_driver  = "default" -> null
      - ipam_options = {} -> null
      - ipv6         = false -> null
      - name         = "task3-network" -> null
      - options      = {
          - "com.docker.network.enable_ipv4" = "true"
          - "com.docker.network.enable_ipv6" = "false"
        } -> null
      - scope        = "local" -> null

      - ipam_config {
          - aux_address = {} -> null
          - gateway     = "172.19.0.1" -> null
          - subnet      = "172.19.0.0/16" -> null
            # (1 unchanged attribute hidden)
        }
    }

  # docker_volume.task3_volume will be destroyed
  - resource "docker_volume" "task3_volume" {
      - driver      = "local" -> null
      - driver_opts = {} -> null
      - id          = "task3-data" -> null
      - mountpoint  = "/var/lib/docker/volumes/task3-data/_data" -> null
      - name        = "task3-data" -> null
    }

Plan: 0 to add, 0 to change, 6 to destroy.

Changes to Outputs:
  - access_urls            = (sensitive value) -> null
  - database_info          = {
      - image      = "mysql:8.0"
      - ip_address = "172.19.0.3"
      - name       = "task3-database"
    } -> null
  - infrastructure_summary = {
      - containers_created = 2
      - images_used        = [
          - "task3-custom-nginx:latest",
          - "mysql:8.0",
        ]
      - networks_created   = 1
      - total_resources    = 5
      - volumes_created    = 1
    } -> null
  - network_info           = {
      - driver = "bridge"
      - name   = "task3-network"
    } -> null
  - volume_info            = {
      - name = "task3-data"
    } -> null
  - web_app_info           = {
      - external_port = 8080
      - image         = "task3-custom-nginx:latest"
      - ip_address    = "172.19.0.2"
      - name          = "task3-web-app"
    } -> null
docker_container.database: Destroying... [id=96039351e0a8c4dc9f6df1fdebf94e66236328bd73aa615ba0bd2f8cd11ace77]
docker_container.web_app: Destroying... [id=10e4c7791462a10cd9d405e9fb6f893a4737affd5f44c2ba4ed3e594fe418261]
docker_container.web_app: Destruction complete after 1s
docker_image.web_app: Destroying... [id=sha256:d4207f969b519c1b6ecc81c0389e867c618e89e633927caebab805417e11abcdtask3-custom-nginx:latest]
docker_container.database: Destruction complete after 1s
docker_volume.task3_volume: Destroying... [id=task3-data]
docker_network.task3_network: Destroying... [id=7784e8bab8c263e33099aabcb216a5b8adf74a96d4c3b990c1fcf747171b7443]        
docker_image.database: Destroying... [id=sha256:e95435ce9c6b5507dc38ba2bf4da9d8d91d6a5d55045e70c0ffc4befd66b1eaemysql:8.0]
docker_image.web_app: Destruction complete after 0s
docker_image.database: Destruction complete after 1s
docker_volume.task3_volume: Destruction complete after 2s
docker_network.task3_network: Destruction complete after 2s

Destroy complete! Resources: 6 destroyed.

```