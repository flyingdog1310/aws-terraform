resource "aws_eip" "prompt" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.server_prompt[0].id
  allocation_id = aws_eip.prompt.id
}
