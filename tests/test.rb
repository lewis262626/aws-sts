require 'minitest/autorun'
require_relative '../Role.rb'

class EulerTest < Minitest::Test

  def test_role_arn_regex_invalid_1
    assert_raises ArgumentError do
      @role = Role.new(role_arn="test")
    end
  end

  def test_role_arn_invalid_2
    assert_raises ArgumentError do
      @role = Role.new(role_arn="arn:")
    end
  end

  def test_role_arn_valid_1
    assert_raises ArgumentError do
      @role = Role.new("arn:aws:iam::123456789012:role/S3Access")
    end
  end
end
