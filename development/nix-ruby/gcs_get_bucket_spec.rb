require "google/cloud/storage"
require "rspec"

RSpec.describe "Google Cloud Storage Bucket Retrieval" do

  # Mock the Google::Cloud::Storage client
  let(:mock_storage) { double(Google::Cloud::Storage) }
  let(:mock_bucket) { double(Google::Cloud::Storage::Bucket, name: bucket_name) }
  let(:bucket_name) { "qwiklabs-gcp-04-e89b9bea5f22-bucket" }

  before do
    # Allow the mock client to return the mock bucket
    allow(mock_storage).to receive(:bucket).with(bucket_name).and_return(mock_bucket)
    # Replace the actual Google::Cloud::Storage class with the mock
    allow(Google::Cloud::Storage).to receive(:new).and_return(mock_storage)
  end

  it "finds and prints the bucket if it exists" do
    # Capture the output to STDOUT
    output = capture(:stdout) do
      # Call your original Ruby code (it will use the mocks)
      load "gcs_get_bucket.rb"
    end

    # Assertions
    expect(output).to include("Bucket found: #{bucket_name}")
    # (Optionally) Check if the pretty-printed output matches your expectations
  end

  it "prints a message if the bucket is not found" do
    # Make the mock return nil when the bucket is not found
    allow(mock_storage).to receive(:bucket).with(bucket_name).and_return(nil)

    output = capture(:stdout) do
      load "gcs_get_bucket.rb"
    end

    expect(output).to include("Bucket not found.")
  end
end
