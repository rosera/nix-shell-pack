require 'google/iam/v1'


def get_iam_policy(resource) # Resource is the resource path

  # Create a client object. The client can be reused for multiple calls.
  #puts "Resource: #{resource}"
  iam_client = Google::Iam::V1::IAMPolicy::Client.new
  # request    = Google::Iam::V1::GetIamPolicyRequest.new(resource: resource)
  # request    = Google::Iam::V1::GetIamPolicyRequest.new(resource: "projects/qwiklabs-gcp-01-ca13e99aed4e")
  # Create a request. To set request fields, pass in keyword arguments.
  # request    = Google::Iam::V1::GetIamPolicyRequest.new
  #puts "Request: #{request}"


  begin
    # policy = iam_client.get_iam_policy(resource:  "projects/qwiklabs-gcp-01-ca13e99aed4e", options: nil)
    policy = iam_client.get_iam_policy(resource:  nil, options: nil)
    # policy = iam_client.get_iam_policy(request)
    # policy = get_iam_policy(request)
    # puts "Policy: #{policy}"
    puts "IAM Policy for #{resource}:"
    # puts " Bindings:"
    policy.bindings.each do |binding|
    puts " Role: #{binding.role}"
    puts " Members: #{binding.members.join(', ')}"

  end

  # You can access other policy properties if needed (etag, version)

  return policy # Return the policy object



  rescue Google::Cloud::Error => e

    puts "Error getting IAM policy: #{e.message}"

    return nil # Return nil to indicate an error

  end

end




# Example Usage:

project_id = 'qwiklabs-gcp-01-ca13e99aed4e' # Replace with your project ID

resource = "projects/#{project_id}" # Example for project-level policy



# For a service account:

# service_account_email = "your-service-account@your-project-id.iam.gserviceaccount.com"

# resource = "projects/#{project_id}/serviceAccounts/#{service_account_email}"



# For a different resource type (e.g., a Cloud Storage bucket):

# bucket_name = "your-bucket-name"

# resource = "projects/#{project_id}/buckets/#{bucket_name}"



policy = get_iam_policy(resource)



if policy

  # Check if a specific user has a certain role:

  user_email = "student-02-c9c06613c51d@qwiklabs.net" # Replace with the user's email

  # role_to_check = "roles/storage.objectViewer" # Example role

  role_to_check = "roles/viewer" # Example role


  policy.bindings.each do |binding|

  if binding.role == role_to_check && binding.members.include?("user:#{user_email}")

    puts "#{user_email} has the #{role_to_check} role."

    break # Stop searching once found

  end

end

else

  puts "Could not retrieve policy"

end
