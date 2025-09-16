resource "local_file" "example" {
content  = "abc!"
filename = "${path.module}/example.txt"
}
