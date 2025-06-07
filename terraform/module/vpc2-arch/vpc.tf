module "vpc2" {
    source = "git::https://github.com/Niranjan-devops/terraform-vpc-module.git"
    region = var.region
    cidr_block_range=var.cidr_block_range
    pub_sub1_cidr_range=var.pub_sub1_cidr_range
    pub_sub1_region=var.pub_sub1_region
    pub_sub2_cidr_range=var.pub_sub2_cidr_range
    pub_sub2_region=var.pub_sub2_region
    priv_sub1_cidr_range=var.priv_sub1_cidr_range
    priv_sub1_region=var.priv_sub1_region

  
}