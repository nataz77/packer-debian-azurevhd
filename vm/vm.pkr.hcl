source "azure-arm" "debian-vm1-vhd" {
  # basics 
  subscription_id = "${var.subid}"
  tenant_id = "${var.tenant}"

  # output settings
  resource_group_name = "${var.rgname}"
  storage_account = "${var.sa}"
  capture_container_name = "images"
  capture_name_prefix = "${var.capturename}"  

  # base image settings
  os_type = "Linux"
  image_publisher = "Debian"
  image_offer = "debian-10"
  image_sku = "10"

  # temp image settings
  location = "West Europe"
  vm_size = "Standard_B2s"
}

source "azure-arm" "debian-vm1-managedimage" {
  # basics 
  subscription_id = "${var.subid}"
  tenant_id = "${var.tenant}"

  # output settings
  resource_group_name = "${var.rgname}"
  storage_account = "${var.sa}"
  capture_container_name = "images"
  capture_name_prefix = "${var.capturename}"  

  # base image settings
  os_type = "Linux"
  image_publisher = "Debian"
  image_offer = "debian-10"
  image_sku = "10"

  # temp image settings
  managed_image_name = "${var.capturename}-managedImage"
  managed_image_resource_group_name = "${var.rgname}"
}

build {
  sources = [
    "azure-arm.debian-vm1-vhd",
    "azure-arm.debian-vm1-managedimage"
  ]

  provisioner "shell" {
    scripts = [
      "scripts/main.sh"
    ]

    environment_vars = [
    ]

    # Run provisioner as sudo
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }
}