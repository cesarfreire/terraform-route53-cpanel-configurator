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
resource "aws_route53_record" "cname_pop" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "pop"
  type    = "CNAME"
  ttl     = "14400"
  records = [format("mail.%s",resource.aws_route53_zone.zona_dns.name)]
}

/*resource "aws_route53_record" "cname_pop3" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "pop3"
  type    = "CNAME"
  ttl     = "14400"
  records = ["mail.ita.locaweb.com.br."]
}

resource "aws_route53_record" "cname_smtp" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "smtp"
  type    = "CNAME"
  ttl     = "14400"
  records = ["mail.ita.locaweb.com.br."]
}

resource "aws_route53_record" "cname_imap" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "imap"
  type    = "CNAME"
  ttl     = "14400"
  records = ["mail.ita.locaweb.com.br."]
}

resource "aws_route53_record" "cname_mail" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "mail"
  type    = "CNAME"
  ttl     = "14400"
  records = ["mail.ita.locaweb.com.br."]
}

resource "aws_route53_record" "cname_pda" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "pda"
  type    = "CNAME"
  ttl     = "14400"
  records = ["mail.ita.locaweb.com.br."]
}

resource "aws_route53_record" "cname_webmail" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "webmail"
  type    = "CNAME"
  ttl     = "14400"
  records = ["webmail-seguro.com.br."]
}

resource "aws_route53_record" "cname_calendario" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "calendario"
  type    = "CNAME"
  ttl     = "14400"
  records = ["calendario.locaweb.com.br."]
}

resource "aws_route53_record" "cname_autodiscover" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = "14400"
  records = ["autodiscover.email.locaweb.com.br."]
}

resource "aws_route53_record" "cname_relatorio" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "relatorio"
  type    = "CNAME"
  ttl     = "14400"
  records = ["relatorio.locaweb.com.br."]
}

resource "aws_route53_record" "cname_relatorios" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "relatorios"
  type    = "CNAME"
  ttl     = "14400"
  records = ["relatorios.locaweb.com.br."]
}

resource "aws_route53_record" "cname_painel" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "painel"
  type    = "CNAME"
  ttl     = "14400"
  records = ["painel.locaweb.com.br."]
}

resource "aws_route53_record" "cname_mobile" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "mobile"
  type    = "CNAME"
  ttl     = "14400"
  records = ["mail.ita.locaweb.com.br."]
}

resource "aws_route53_record" "cname_gerenciador" {
  zone_id = resource.aws_route53_zone.zona_dns.zone_id
  name    = "gerenciador"
  type    = "CNAME"
  ttl     = "14400"
  records = ["gerenciador.locaweb.com.br."]
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
}*/