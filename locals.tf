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
