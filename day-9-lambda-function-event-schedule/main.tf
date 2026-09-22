resource "aws_iam_role" "lambda_role" {
  name = "lambda_excecution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
    role = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_lambda_function" "lambda_function" {
    function_name = "my_lambda_function"
    role = aws_iam_role.lambda_role.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.12"
    timeout = 10
    memory_size = 128
    filename = "lambda_function.zip"

     source_code_hash = filebase64sha256("lambda_function.zip")
}

resource "aws_cloudwatch_event_rule" "every_two_minutes" {
    name = "every_2_minutes"
    schedule_expression  = "cron(0/2 * * * ? *)"

} 

resource "aws_cloudwatch_event_target" "lambda_target" {
     rule      = aws_cloudwatch_event_rule.every_two_minutes.name
     target_id = "lambda"
     arn       = aws_lambda_function.lambda_function.arn
}


resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_two_minutes.arn
}



