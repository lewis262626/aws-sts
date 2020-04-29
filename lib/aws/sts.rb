require "aws/sts/version"
require "aws/sts/role"
require 'aws_config'

module Aws
  module Sts
    class Cli < StandardError
      def initialize
      end

      def main
        if ARGV.empty?
          Role.blurb
        else
          profile = ARGV[0]
          role_arn = AWSConfig[profile].role_arn
          region   = AWSConfig[profile].region
          @role = Role.new(role_arn, region, profile)
          @role.print_keys
        end
      end
    end
  end
end
