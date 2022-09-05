variable "FRAPPE_VERSION" {
  default = "v14.5.0"
}

variable "ERPNEXT_VERSION" {
  default = "v14.0.3"
}

variable "REGISTRY_NAME" {
  default = "custom_images"
}

variable "BACKEND_IMAGE_NAME" {
  default = "custom_worker"
}

variable "FRONTEND_IMAGE_NAME" {
  default = "custom_nginx"
}

variable "VERSION" {
  default = "latest"
}

group "default" {
    targets = ["backend", "frontend"]
}

target "backend" {
    dockerfile = "images/backend.Dockerfile"
    tags = ["${REGISTRY_NAME}/${BACKEND_IMAGE_NAME}:${VERSION}"]
    args = {
      "ERPNEXT_VERSION" = ERPNEXT_VERSION
    }
}

target "frontend" {
    dockerfile = "images/frontend.Dockerfile"
    tags = ["${REGISTRY_NAME}/${FRONTEND_IMAGE_NAME}:${VERSION}"]
    args = {
      "FRAPPE_VERSION" = FRAPPE_VERSION
      "ERPNEXT_VERSION" = ERPNEXT_VERSION
    }
}
