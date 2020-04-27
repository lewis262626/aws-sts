require 'aws-sdk'
require 'aws_config'

class Role
  attr_accessor :role_arn

  def initialize(role_arn,region, profile)
    if role_arn =~ /^arn:aws:iam::(\d+):role\/([^\/]+)(\/.+)?$/
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

  def get_keys
    resp = @client.assume_role({
      role_arn: @role_arn,
      role_session_name: @profile,
    })

    resp
  end
end

if __FILE__ == $0
  profile = ARGV[0]
  role_arn = AWSConfig[profile].role_arn
  region   = AWSConfig[profile].region
  role = Role.new(role_arn, region, profile)
  credentials = role.get_keys.credentials

  puts "export AWS_ACCESS_KEY_ID=#{credentials.access_key_id}"
  puts "export AWS_SECRET_ACCESS_KEY=#{credentials.secret_access_key}"
  puts "export AWS_SESSION_TOKEN=#{credentials.session_token}"
  puts "export ASSUMED_ROLE=#{profile}"
  puts "# run eval $(ruby Role.rb <profile>)"
end
