module "key-vault" {
  source                = "./modules/1-key-vault"
  environment           = var.environment
}

module "budget-monitoring" {
  source                = "./modules/2-budget-monitoring"
}

module "monitoring" {
  source                = "./modules/3-monitoring"
}

module "web-page" {
  source                = "./modules/5-web-page"
}

module "storage" {
  source                = "./modules/6-storage"
}

module "iot" {
  source                = "./modules/8-iot"
}

module "desktop-virtualization" {
  source                = "./modules/9-desktop-virtualization"
  environment           = var.environment
}