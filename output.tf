output "app_address" {
  description = "The addres of the final running application."
  value       = "https://${var.app_name}.azurewebsites.net/"
}
