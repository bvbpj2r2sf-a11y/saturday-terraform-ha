resource "aws_iam_role" "saturday_role" {
    name = "saturday-role"
    assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "saturday_s3_policy"{
    name = "saturday-s3-policy"
    role = aws_iam_role.saturday_role.id
    policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "satrurdsay_instance_profile" {
    name = "saturday-intance-profile"
    role = aws_iam_role.saturday_role.id
  
}