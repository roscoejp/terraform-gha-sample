output "hash" {
    value = filesha256("main.tf")
}