# nomad-desired-state
Desired state for the Hasicorp Stack AWS

### Getting started
```
job "nomoperator" {
  datacenters = ["DC1"]
  group "nomoperator" {
    count = 1
    task "nomoperator" {
      driver = "exec"
      config {
        command = "nomoperator"
        args    = ["bootstrap", "git", "--url", "https://github.com/SirCAS/nomad-desired-state.git", "--branch", "main", "--path", "/jobs"]
      }
      artifact {
        source      = "https://github.com/jonasvinther/nomad-gitops-operator/releases/download/v0.0.1/nomad-gitops-operator_0.0.1_linux_amd64.tar.gz"
        destination = "local"
        mode        = "any"
      }
    }
  }
}
```
