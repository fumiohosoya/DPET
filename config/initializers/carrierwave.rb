CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-southeast-1',
      path_style: true
  }
  
  
  
  case Rails.env
    when 'production'
      config.fog_directory = 'dpetphotos'
      config.asset_host = 'https://s3-ap-southeast-1.amazonaws.com/dpetphotos'  
      
    when 'development'
      config.fog_directory = 'dpetphotos'
      config.asset_host = 'https://s3-ap-southeast-1.amazonaws.com/dpetphotos'  
       

     when 'test'
      config.fog_directory = 'dpetphotos'
      config.asset_host = 'https://s3-ap-southeast-1.amazonaws.com/dpetphotos'  
  end
end