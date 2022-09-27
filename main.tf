module "network" {
  source     = "./Network"
  cidr_block = local.vpc_cidr
  #   public_cidrs = ["10.123.2.0/24","10.123.4.0/24"]
  #   private_cidrs =["10.123.1.0/24","10.123.3.0/24","10.123.5.0/24"]
  #security_groups  = local.security_groups
  #access_ip        = var.access_ip
  max_subnets         = local.max_subnets
  private_sn_count    = local.private_sn_count
  public_sn_count     = local.public_sn_count
  public_Network_CID  = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_Network_CID = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  #db_subnet_group  = true #for condition of creating db security groups
  #bastion_lb_sg          = module.networking.public_subnet_group
  #instance-lb-sg         = module.network.
  #mtc_lb_sg              = module.networking.public_sg
  load_balancer_type = var.load_balancer_type
  aws_lb_name        = var.aws_lb_name
  #tg_port                = var.port
  #tg_protocol            = var.protocol
  #lb_healthy_threshold   = var.healthy_threshold
  #lb_unhealthy_threshold = var.unhealthy_threshold
  #lb_interval            = var.interval
  #lb_timeout             = var.timeout
  #vpc_id = module.networking.vpc_id
}

module "instance" {
  source       = "./Instance"
  ubuntu-ami   = var.ubuntu-ami
  instance-ami = local.ami-id
  #vol_size            = 10
  bastion_sg        = module.network.bastion-sg
  instance-sg       = module.network.instance-sg
  public_subnet_id  = module.network.bastion_subnet_group[0]
  private_subnet_id = module.network.private_subnet_group
  instance_count   = local.private_sn_count
  #public_key_path     = "/home/ubuntu/.ssh/keymtc.pub"
  key_name = aws_key_pair.mykeypair.key_name
  #user_data_path      = "${path.root}/userdata.tpl"
  #db_endpoint         = module.database.db_endpoint
  #dbuser              = var.dbusername
  #dbpassword          = var.dbpassword
  #dbname              = var.dbname
  lb_target_group_arn = module.network.aws_lb_target_group_arn
  #tg_port             = 8000
  #private_key_path     = "/home/ubuntu/.ssh/keymtc"
}