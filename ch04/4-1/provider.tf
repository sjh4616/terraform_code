terraform {
    # 테라폼 버전 설정
    required_version = ">= 1.5.7, < 2.0.0"

    # 공급자 설정
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "6.14.1"
      }
    }
}

provider "aws" {
  # Configuration options
  region = "ap-northeast-2"
}