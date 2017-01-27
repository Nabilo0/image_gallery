require "instagram"

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_APP_ID']
  config.client_secret = ENV['INSTAGRAM_APP_SECRET']
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
  
  # config.omniauth :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
end
