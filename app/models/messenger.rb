module Messenger
 def send_sms(phone)
	acct_sid = ENV['TWILIO_ACCOUNT_SID']
	auth_token = ENV['TWILIO_AUTH_TOKEN']
    # @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new acct_sid, auth_token
    from = '+14356592698'
    # byebug
    message = @client.account.messages.create(
    	:from => from,
    	:to => phone,
    	:body => '		HH 
                  SSSSSS
                 SSSSSSSS
                 S )))) S 
                SS =  = SSS
               SSS o  o  SSS
              SSSS   9   SSSS
               SSS  __  SSS
                SSS    SSS
                   W   W
                  WW  WWW
                WWWW  WWWW 
                WWWWWWWWWW'
    	)
end
end