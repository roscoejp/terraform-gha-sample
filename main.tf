# Modify this line to change the sha
output "hash" {
    value = filesha256("main.tf")
}