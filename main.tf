# Modify this line
output "hash" {
    value = filesha256("main.tf")
}

output "tfvars" {
    value = filesha256("issue.tfavrs.json")
}