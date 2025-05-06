resource "aws_iam_role" "ec2_ssm" {
	name = var.ssm_ec2_role_name
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [{
			Effect = "Allow",
			Principal = {
				Service = "${var.assume_role_policy_service}"
			},
			Action = "sts:AssumeRole"
		}]
	})
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
	role = aws_iam_role.ec2_ssm.name
	policy_arn = var.policy_arn
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
	name = var.ssm_ec2_profile_name
	role = aws_iam_role.ec2_ssm.name
}