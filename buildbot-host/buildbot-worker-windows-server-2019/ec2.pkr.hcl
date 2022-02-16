packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "buildbot_authenticode_password" {
  type = string
}

variable "buildbot_windows_server_2019_buildbot_user_password" {
  type = string
}

variable "buildbot_windows_server_2019_ec2_region" {
  type = string
}

variable "buildbot_windows_server_2019_winrm_password" {
  type = string
}

variable "buildbot_windows_server_2019_worker_password" {
  type = string
}

variable "buildmaster_address" {
  type = string
}

source "amazon-ebs" "buildbot-worker-windows-server-2019" {
  ami_name         = "buildbot-worker-windows-server-2019-2"
  communicator     = "winrm"
  force_deregister = true
  instance_type    = "t3a.large"
  region           = var.buildbot_windows_server_2019_ec2_region

  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 50
    delete_on_termination = true
  }

  source_ami_filter {
    filters     = {
      name                = "Windows_Server-2019-English-Full-Base-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["801119661308"]
  }
  user_data        = templatefile("${path.root}/bootstrap_win.pkrtpl.hcl", { winrm_password = var.buildbot_windows_server_2019_winrm_password })
  winrm_password   = var.buildbot_windows_server_2019_winrm_password
  winrm_username   = "Administrator"
}

build {
  name    = "buildbot-worker-windows-server-2019"

  provisioner "file" {
    sources     = [ "../../base.ps1",
                    "../../msibuilder.ps1",
                    "../../python.ps1",
                    "../../pip.ps1",
                    "../../build-deps.ps1",
                    "../authenticode.pfx",
                    "import-signing-cert.ps1",
                    "create-buildbot-user.ps1",
                    "get-openvpn-vagrant.ps1",
                    "../../buildbot.ps1",
                    "../../vsbuildtools.ps1"]
    destination = "C:/Windows/Temp/"
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/base.ps1"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/import-signing-cert.ps1 -password ${var.buildbot_authenticode_password}"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/msibuilder.ps1 -workdir C:\\Windows\\Temp"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/python.ps1"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/pip.ps1"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/build-deps.ps1 -workdir C:\\Users\\buildbot\\buildbot\\windows-server-2019-latent-ec2-msbuild"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/create-buildbot-user.ps1 -password ${var.buildbot_windows_server_2019_buildbot_user_password}"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/get-openvpn-vagrant.ps1"]
  }
  provisioner "powershell" {
    inline = ["C:\\Windows\\Temp\\buildbot.ps1 -openvpnvagrant C:\\Users\\buildbot\\openvpn-vagrant -workdir C:\\Users\\buildbot -buildmaster ${var.buildmaster_address} -workername windows-server-2019-latent-ec2 -workerpass ${var.buildbot_windows_server_2019_worker_password} -user buildbot -password ${var.buildbot_windows_server_2019_buildbot_user_password}"]
  }
  provisioner "powershell" {
    inline = ["C:/Windows/Temp/vsbuildtools.ps1"]
  }
  provisioner "windows-restart" {}
  provisioner "powershell" {
    # make sure to run user data scripts on first boot from AMI
    inline = ["C:/ProgramData/Amazon/EC2-Windows/Launch/Scripts/InitializeInstance.ps1 –Schedule"]
  }
  sources = [
    "source.amazon-ebs.buildbot-worker-windows-server-2019"
  ]
}
