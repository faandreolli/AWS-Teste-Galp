locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  datadecode = jsondecode(file("${path.root}/manifest.json"))
  data       = [for builds in local.datadecode.builds : builds.artifact_id]
  slipdata   = split(":", local.data[0])
  ami-id     = tostring(local.slipdata[1])
}


locals {
  max_subnets      = var.max_subnets <= "3" ? var.max_subnets : ""
  private_sn_count = var.private_sn_count <= "3" ? var.private_sn_count : ""
  public_sn_count  = var.public_sn_count <= "3" ? var.public_sn_count : ""
}




#locals {
#  security_groups = {
#    public = {
#      name        = "pubic_sg"
#      description = "Security Group for Public Access"
#      ingress = {
#        ssh = {
#          from        = 22
#          to          = 22
#          protocol    = "tcp"
#          cidr_blocks = [var.access_ip]
#        }
#        http = {
#          from        = 80
#          to          = 80
#          protocol    = "tcp"
#          cidr_blocks = ["0.0.0.0/0"]
#        }
#        
#      }
#    }
#  }
#}'