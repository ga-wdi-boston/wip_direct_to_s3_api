class Amazon # no inheritance here bc this class does not connect to Postgres

  # this method will be called in the Amazon controller
  # it takes as an argument the filename that will be uploaded
  def self.sign(filename)
    # the aws-sdk-core gem gives us the Aws module

    credentials = Aws::Credentials.new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_ACCESS_KEY'])

    # here we create a new aws client
    client = Aws::S3::Client.new(region:'us-east-1', credentials: credentials)

    # here we create a new presigner, which is like a ticket giver, passing in our newly created client as an argument
    signer = Aws::S3::Presigner.new(client: client)
    signer.presigned_url(:get_object,
                          key: "uploads/#{SecureRandom.uuid}/#{filename}",
                          bucket: ENV['MYBUCKET'])
  end
end
