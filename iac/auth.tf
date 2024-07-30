resource "local_sensitive_file" "ingestEventsPassword" {
  filename = "../nginx/etc/.htpasswd"
  content = <<EOF
${var.settings.auth.user}:${bcrypt(var.settings.auth.password)}
EOF
}