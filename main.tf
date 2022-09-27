module "network" {
  source     = "./Network"
  cidr_block = local.vpc_cidr
  max_subnets         = local.max_subnets
  private_sn_count    = local.private_sn_count
  public_sn_count     = local.public_sn_count
  public_Network_CID  = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_Network_CID = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  load_balancer_type = var.load_balancer_type
  aws_lb_name        = var.aws_lb_name
}

module "instance" {
  source       = "./Instance"
  ubuntu-ami   = var.ubuntu-ami
  instance-ami = local.ami-id
  bastion_sg        = module.network.bastion-sg
  instance-sg       = module.network.instance-sg
  public_subnet_id  = module.network.bastion_subnet_group[0]
  private_subnet_id = module.network.private_subnet_group
  instance_count   = local.private_sn_count
  key_name = aws_key_pair.mykeypair.key_name
  lb_target_group_arn = module.network.aws_lb_target_group_arn
}

resource "null_resource" "health_check" {

 provisioner "local-exec" {
    
    command = "Remove-item manifest.json"
    interpreter = ["PowerShell", "-Command"]
  }

  depends_on = [
    module.instance,
    module.network
  ]
}