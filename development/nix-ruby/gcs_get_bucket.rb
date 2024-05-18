require "google/cloud/storage"
require "pp"  # Load the 'pretty print' module

storage = Google::Cloud::Storage.new
bucket_name = "qwiklabs-gcp-04-e89b9bea5f22-bucket" 

bucket = storage.bucket bucket_name
if bucket
  puts "Bucket found: #{bucket.name}"
  # bucket_data = bucket.to_gapi  # Convert to Google API Client format

  # Print a nicely formatted representation of the response
  # pp bucket_data
  pp bucket
else
  puts "Bucket not found."
end
