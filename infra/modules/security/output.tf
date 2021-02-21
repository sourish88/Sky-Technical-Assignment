output "web_sec_grp_id" {
    value = aws_security_group.web.id
}

output "web_elb_sec_grp_id" {
    value = aws_security_group.elb_web.id
}
