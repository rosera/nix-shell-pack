require "google/cloud/storage"     # Load Google Cloud Storage module
require "pp"                       # Load the 'pretty print' module


## BUCKET_NAME = "BUCKET_AVAILABLE" 
BUCKET_NAME = "BUCKET_UNAVAILABLE" 

def gcs_bucket_exists?(bucket_name = BUCKET_NAME)
  storage = Google::Cloud::Storage.new
  bucket = storage.bucket(BUCKET_NAME)
  bucket.nil? ? false: true
end

if gcs_bucket_exists? 
  puts "Bucket #{BUCKET_NAME} found."
  # Print a nicely formatted representation of the response
  ## pp bucket
else
    puts "Bucket #{BUCKET_NAME} not found."
end
