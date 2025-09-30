resource "random_pet" "name" {
    keepers = {
      ami_id = timestamp()
    }  
}
resource "random_password" "password" {
    length  = var.isDB ? 16 : 10
    special = var.isDB ? true : false
    override_special = "!#$%*"  
}