output "zone_id" {
  value = module.dns.zone_id
}

output "cert_arn" {
  value = module.acm.cert_arn
}

output "oidc_provider_arn" {
  value = module.oidc.oidc_provider_arn
}
