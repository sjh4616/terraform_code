variable "my_var" {
    default = "var1"
}
resource "local_file" "abc" {
  content = var.my_var
  filename = "${path.module}/abc.txt"
}