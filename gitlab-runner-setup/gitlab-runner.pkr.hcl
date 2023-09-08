variable "ami_id" {
  type    = string
  default = "ami-03f65b8614a860c29"
}

locals {
  app_name = "gitlab_runner"
}

source "amazon-ebs" "gitlab" {
  ami_name          = "${local.app_name}"
  instance_type     = "t2.micro"
  region            = "us-west-2"
  availability_zone = "us-west-2a"
  source_ami        = "${var.ami_id}"
  ssh_username      = "ubuntu"
  tags = {
    Environment  = "dev"
    Name         = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.gitlab"]

  provisioner "ansible" {
  playbook_file = "ansible/gitlab-runner.yml"
  } 
  
  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
  }
}
