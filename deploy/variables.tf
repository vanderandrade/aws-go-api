variable "lambda_role_name" {
  type = string
  default = "LambdaExecutionRole"
}

variable "lambda_function_name" {
  type = string
}

variable "lambda_environment_variables" {
  type = map(string)
  default = {}
}

variable "lambda_runtime" {
  type = string
  default = "go1.x"
}

variable "lambda_handler" {
  type = string
  default = "main"
}

variable "lambda_memory_size" {
  type = number
  default = 512
}

variable "lambda_timeout" {
  type = number
  default = 30
}

variable "lambda_additional_tags" {
  type = map(string)
  default = {}
}