module "bastion" {
  source        = "./modules/bastion"
  create        = true
  instances     = 1
  instance_name = "bastion-vm"
  ssh_keys      = [
    {
      user      = "me"
      publickey = file("${path.module}/ssh-pub-keys/id_rsa.pub")
    }
  ]
}