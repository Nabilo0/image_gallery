class BraintreeController < ApplicationController

def new
  @client_token = Braintree::ClientToken.generate
  # byebug
end


def checkout
	nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
	# byebug
	result = Braintree::Transaction.sale(
				:amount => "50.00", #this is currently hardcoded
				:payment_method_nonce => nonce_from_the_client,
				:options => {
											:submit_for_settlement => true
										})

if result.success?
	# @user
	# current_user.refreshtoken == nonce_from_the_client
	# byebug
	# current_user.update_attributes(:refreshtoken => nonce_from_the_client)
	 current_user.update_attributes(:payment => nonce_from_the_client )

 	redirect_to user_path(current_user), :flash => { :success => "Transaction successful!"}
else
redirect_to new_user_braintree_path(current_user), :flash => {:error => "Transaction filed , Please try again"}
 
  end
 end
end
