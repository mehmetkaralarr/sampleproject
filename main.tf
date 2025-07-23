resource "azuread_application"  "this" {
  display_name = var.display_name
  identifier_uris = var.identifier_uris
  owners =toset(concat(var.owners, [data.azuerad_client_config.current.object_id]))
  group_membership_claims = var.group_membership_claims
  dynamic "optional_claims" {
    for_each = var.enable_optional_claims ? [var.enable_optional_claims] : []
    content {
        dynamic "access_token" {
            for_each = var.access_token_claims
            content {
                name = access_token.key
              essential= lookup(access_token.value, "essential", null)
              additional_properties = lookup(access_token.value, "additioanl_properties", [])
              source = lookup(access_token.value, "source", null)
            }
        }
    }
  }
}