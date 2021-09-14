provider "nsxt" {
  host                  = var.nsx_manager
  username              = var.nsx_username
  password              = var.nsx_password
  allow_unverified_ssl  = true
}
data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = "nsx-overlay-transportzone"
}
data "nsxt_policy_tier1_gateway" "t1_gateway" {
  display_name = "T1-VMworld-TF"
}
resource "nsxt_policy_segment" "web" {
  display_name        = "VMworld-web-tf"
  description         = "Terraform provisioned Web Segment for VMworld"
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1_gateway.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr        = "172.191.11.1/24"
  }
}
resource "nsxt_policy_segment" "app" {
  display_name        = "VMworld-app-tf"
  description         = "Terraform provisioned App Segment for VMworld"
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1_gateway.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr        = "172.191.12.1/24"
  }
}
resource "nsxt_policy_segment" "db" {
  display_name        = "VMworld-db-tf"
  description         = "Terraform provisioned DB Segment for VMworld"
  connectivity_path   = data.nsxt_policy_tier1_gateway.t1_gateway.path
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  subnet {
    cidr        = "172.191.13.1/24"
  }
}
