require "minitest/autorun"
require "google/cloud/storage"
require "stringio"
require "mocha/minitest"
require_relative "gcs_get_bucket"

class GetBucketTest < Minitest::Test

  def setup
    # Create a mock storage object using Mocha
    @mock_storage = mock('storage')
  end

  def test_gcs_bucket_exists
    result = gcs_bucket_exists?() 
    output = StringIO.new
    $stdout = output
    $stdout = STDOUT
    output_string = output.string.strip
    puts "\n-- Actual Output --\n#{output_string}"

    assert(result, "Bucket #{BUCKET_NAME} should exist")  
  end

  def test_bucket_not_found
    # Mock the `bucket` method to return nil
    @mock_storage.stubs(:bucket).with(BUCKET_NAME).returns(nil)
    Google::Cloud::Storage.stub :new, @mock_storage do
      result = gcs_bucket_exists?()
      refute(result, "Bucket #{BUCKET_NAME} should not exist")
    end
  end
end
