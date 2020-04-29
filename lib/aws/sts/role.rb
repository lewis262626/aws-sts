#!/usr/bin/env ruby

require 'aws-sdk'
require 'aws_config'

require 'aws-sdk'

class Role
  attr_accessor :role_arn

  def initialize(role_arn,region, profile)
    if self.class.test_role_arn(role_arn)
      @role_arn = role_arn
    else
      raise ArgumentError.new("Role Arn is not valid")
    end

    @region   = region
    @profile  = profile
    @client   = Aws::STS::Client.new(
      region: @region,
      profile: @profile,
    )
  end


  def self.test_role_arn(role_arn)
    role_arn =~ /^arn:aws:iam::(\d+):role\/([^\/]+)(\/.+)?$/
  end

  def self.blurb
    puts "aws-sts <role>"
  end

  def print_keys

    credentials = get_keys
    puts "export AWS_ACCESS_KEY_ID=#{credentials.access_key_id}"
    puts "export AWS_SECRET_ACCESS_KEY=#{credentials.secret_access_key}"
    puts "export AWS_SESSION_TOKEN=#{credentials.session_token}"
    puts "export ASSUMED_ROLE=#{@profile}"
    puts "# run eval $(ruby Role.rb <profile>)"
  end

  private 

  def get_keys
    resp = @client.assume_role({
      role_arn: @role_arn,
      role_session_name: @profile,
    })

    resp.credentials
  end
end