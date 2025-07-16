provider "google" {
    project = "your project name "
    
  
}
resource "google_compute_network" "custom_vpc" {
  name                    = "dev-vpc"
  auto_create_subnetworks = false  # Set to true for auto mode
  description             = "Terraform-created VPC"
}