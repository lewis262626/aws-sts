require "aws/sts/version"
require "aws/sts/role"

module Aws
  module Sts
    class Error < StandardError; end
      def main
        if ARGV[0].empty?
          role.blurb
        else
          profile = ARGV[0]
          role_arn = AWSConfig[profile].role_arn
          region   = AWSConfig[profile].region
          role = Role.new(role_arn, region, profile)
          credentials = role.print_keys
  end
end
