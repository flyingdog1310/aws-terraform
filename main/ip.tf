resource "aws_eip" "prompt" {
  count  = var.server_prompt_enabled ? 1 : 0
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.server_prompt_enabled ? 1 : 0
  instance_id   = aws_instance.server_prompt[0].id
  allocation_id = aws_eip.prompt[0].id
}
