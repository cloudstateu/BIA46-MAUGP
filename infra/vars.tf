variable "location" {
  default = "westeurope"
}

#Number of dev networks to create
variable "number-of-net" {
  default = "1"
}

#Default User
variable "default-admin-username" {
  default = "defadminuser"
}

#Default Password
variable "default-admin-pass" {
  default = "Moje12345678!"
}

#VNET HUB ADDRESS
variable "vnet-hub" {
  default = "10.10.0.0/24"
}

variable "vnet-hub-gateway-subnet" {
  default = "10.10.0.0/26"
}

variable "vnet-hub-azurefirewall-subnet" {
  default = "10.10.0.64/26"
}

#VNET spoke ADDRESS
variable "vnet-spoke-kubenet" {
  default = "10.10.1.0/24"
}

variable "vnet-spoke-cni" {
  default = "10.10.2.0/24"
}