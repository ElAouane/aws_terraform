data "template_file" "init-script" {
  template = file("../dev/scripts/init.cfg")
}
data "template_file" "npm-script" {
  template = file("../dev/template/init.sh.tpl")
}
//data "template_file" "shell-script" {
//  template = file("../dev/scripts/volumes.sh")
//  vars = {
//    DEVICE = var.INSTANCE_DEVICE_NAME
//  }
//}

data "template_cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init-script.rendered
  }

  part {
    filename = "init.sh.tpl"
    content = data.template_file.npm-script.rendered
  }

//  part {
//    content_type = "text/x-shellscript"
//    content      = data.template_file.shell-script.rendered
//  }
}



