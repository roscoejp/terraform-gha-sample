# Modify this line to make changes
output "hash" {
    value = filesha256("main.tf")
}
