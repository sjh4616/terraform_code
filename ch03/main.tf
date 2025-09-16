resource "local_file" "example" {
content  = "Hello World"
filename = "${path.module}/example.txt"
}
