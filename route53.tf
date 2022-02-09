resource "aws_route53_zone" "zona_dns" {
  name = "${terraform.workspace}"
}

resource "aws_route53_record" "registro_mx" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = resource.aws_route53_zone.zona_dns.name
  type    = "MX"
  ttl     = "14400"
  records = [format("0 mail.%s", resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "registros_txt_raiz" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = resource.aws_route53_zone.zona_dns.name
  type    = "TXT"
  ttl     = "14400"
  records = [format("v=spf1 +a +mx +ip4:%s %s", var.ip_hospedagem, "-all")]
}

resource "aws_route53_record" "a_mail" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "mail"
  type    = "A"
  ttl     = "14400"
  records = [var.ip_hospedagem]
}

resource "aws_route53_record" "cname_autoconfig" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "autoconfig"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_autodiscover" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_cpcalendars" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "cpcalendars"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_cpcontacts" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "cpcontacts"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_cpanel" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "cpanel"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_ftp" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "ftp"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_webdisk" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "webdisk"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_webmail" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "webmail"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_whm" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "whm"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_e-mail" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "e-mail"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_imap" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "imap"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_pop" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "pop"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_pop3" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "pop3"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_route53_record" "cname_smtp" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "smtp"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

resource "aws_ses_domain_identity" "ses_dominio" {
    domain = "${terraform.workspace}"
}

resource "aws_ses_domain_dkim" "dkim_cliente" {
    domain = aws_ses_domain_identity.ses_dominio.domain
}

resource "aws_route53_record" "example_amazonses_dkim_record" {
    count   = 3
    zone_id = resource.aws_route53_zone.zona_dns.zone_id
    name    = "${element(aws_ses_domain_dkim.dkim_cliente.dkim_tokens, count.index)}._domainkey"
    type    = "CNAME"
    ttl     = "14400"
    records = ["${element(aws_ses_domain_dkim.dkim_cliente.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

output "zone_id" {
    description = "ID da zona"
    value       = resource.aws_route53_zone.zona_dns.zone_id
}

output "nameservers" {
    description = "NameServers do domínio"
    value       = resource.aws_route53_zone.zona_dns.name_servers
}