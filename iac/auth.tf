# Creates the authentication for the nginx service.
resource "local_sensitive_file" "authentication" {
  filename = "../nginx/etc/.htpasswd"
  content = <<EOF
${var.settings.auth.user}:${bcrypt(var.settings.auth.password)}
EOF
}