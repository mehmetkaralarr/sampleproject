variable "display_name" {
  description = "The display name for the application."
  type        = string
}

variable "identifier_uris" {
  description = "A set of user-defined URI(s) that uniquely identify an application within its Azure AD tenant, or within a verified custom domain if the application is multi-tenant."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals."
  type        = list(string)
  default     = []
}

variable "group_membership_claims" {
  type        = set(string)
  description = "A set of strings containing membership claims issued in a user or OAuth 2.0 access token that the app expects. Possible values are `None`, `SecurityGroup`, `DirectoryRole`, `ApplicationGroup` or `All`."
  default     = ["All"]
}

variable "enable_optional_claims" {
  default     = false
  type        = bool
  description = "Decide if optional_claim should be enabled for token."
}

variable "access_token_claims" {
  type = map(object({
    essential             = optional(bool)
    additional_properties = optional(list(string))
    source                = optional(string)
  }))
  default     = {}
  description = <<DESCRIPTION
`access_token_claims` blocks support the following:
- `additional_properties` - List of additional properties of the claim. If a property exists in this list, it modifies the behaviour of the optional claim. Possible values are: `cloud_displayname`, `dns_domain_and_sam_account_name`, `emit_as_roles`, `include_externally_authenticated_upn_without_hash`, `include_externally_authenticated_upn`, `max_size_limit`, `netbios_domain_and_sam_account_name`, `on_premise_security_identifier`, `sam_account_name`, and `use_guid`.
- `essential` - Whether the claim specified by the client is necessary to ensure a smooth authorization experience.
- `source` - The source of the claim. If source is absent, the claim is a predefined optional claim. If source is user, the value of name is the extension property from the user object.

The key will be the name of the claim.

Example:
```
access_token_claims = {
  groups = {
    essential = true
  }
  my_other_claim = {}
}
```
DESCRIPTION    
}