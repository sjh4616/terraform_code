output "id" {
    value = random_pet.name.id
}
output "pw" {
    value = nonsensitive(random_password.password.result)
}