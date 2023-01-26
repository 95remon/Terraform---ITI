output "private-load-balancer-dns" {
    value = aws_alb.private-alb.dns_name
}

output "public-tg-arn" {
    value = aws_alb_target_group.public-tg.arn
}

output "private-tg-arn" {
    value = aws_alb_target_group.private-tg.arn
}

output "private-alb-sg-id" {
    value = aws_security_group.private-alb-sg.id
}

output "public-lb-dns" {
    value = aws_alb.public-alb.dns_name
}