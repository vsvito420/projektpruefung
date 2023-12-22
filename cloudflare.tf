terraform {
    required_providers {
        cloudflare = {
            source = "cloudflare/cloudflare"
            version = "~> 4.0"
        }
    }
}

provider "cloudflare" {
    api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
    type        = string
    description = "API token for Cloudflare"
}

/*resource "cloudflare_record" "www" {
    # ...
}

resource "cloudflare_page_rule" "www" {

}
*/