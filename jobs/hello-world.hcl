job "hello_world" {
  
  datacenters = [
  "dc1"
]
  type = "service"

  constraint {
    attribute = "${meta.type}"
    value     = "client"
  }

  group "app" {
    count = 3

    network {
      port "http" {
        to = 8000
      }
    }

    
    service {
      name = "webapp"
      tags = [
  "traefik.enable=true",
  "traefik.http.routers.webapp.rule=Host(`escargot-lb-tf-1014484851.eu-central-1.elb.amazonaws.com`)"
]
      port = "http"

      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }


    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "server" {
      driver = "docker"

      config {
        image = "mnomitch/hello_world_server"
        ports = ["http"]
      }

      env {
        MESSAGE = "Hello from Nomad!"
      }
    }
  }
}
