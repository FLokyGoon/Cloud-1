# Import DNS outputs from the separate DNS project
data "terraform_remote_state" "dns" {
  backend = var.dns_remote_backend
  config = {
    path = var.dns_remote_state_path
  }
}