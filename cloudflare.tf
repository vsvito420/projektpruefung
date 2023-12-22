# Configure the Cloudflare provider using the required_providers stanza
# required with Terraform 0.13 and beyond. You may optionally use version
# directive to prevent breaking changes occurring unannounced.


provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
variable "cloudflare_api_token" {
  type = string
    sensitive = true
}

# Create a page rule
#resource "cloudflare_page_rule" "www" {
  # ...
#}