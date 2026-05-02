output "cert_arn" {
  value = aws_acm_certificate_validation.wildcard.certificate_arn
}
