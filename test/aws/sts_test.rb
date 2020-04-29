require "test_helper"

class Aws::StsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Aws::Sts::VERSION
  end

  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html
  def test_regex_1
    arn = "arn:aws:iam::123456789012:role/S3Access"
    assert Role.test_role_arn arn
  end

  def test_regex_2
    arn = "arn:aws:iam::123456789012:role/application_abc/component_xyz/S3Access"
    assert Role.test_role_arn arn
  end

  def test_wrong_regex_1
    arn = "test"
    refute Role.test_role_arn arn
  end

  def test_wrong_regex_2
    arn = "arn:aws:iam:::123456789012:role/application_abc/component_xyz/S3Access"
    refute Role.test_role_arn arn
  end
end
