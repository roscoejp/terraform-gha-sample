# Modify this line
output "hash" {
    value = filesha256("main.tf")
}