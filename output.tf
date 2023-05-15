output "app_url" {
  description = "The url of the final running application."
  value       = "https://${azurerm_linux_web_app.django_images.name}.azurewebsites.net/"
}
