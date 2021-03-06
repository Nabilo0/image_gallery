 Rails.application.config.middleware.use OmniAuth::Builder do

  provider :instagram, ENV['INSTAGRAM_APP_ID'], ENV['INSTAGRAM_APP_SECRET'], provider_ignores_state: true

  # provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'],
  #   scope: 'user:email'
  
  # provider :twitter, ENV['TWITTER_CLIENT_ID'],
  #   ENV['TWITTER_CLIENT_SECRET']
  
  # provider :facebook, ENV['FACEBOOK_CLIENT_ID'],
  #   ENV['FACEBOOK_CLIENT_SECRET']
  
  # provider :linked_in, ENV['LINKEDIN_CLIENT_ID'], ENV['LINKEDIN_CLIENT_SECRET']

  # Google authentication was problematic at first
  # I had to provide the redirect_uri here

  # provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_sope: 'email profile',
  #   access_type: 'online',
  #   setup: (lambda do |env|
  #     request = Rack::Request.new(env)
  #     env['omniauth.strategy'].options['token_params'] = {:redirect_uri => 'http://127.0.0.1:3000/auth/google_oauth2/callback'}
  #   end)}
end
 