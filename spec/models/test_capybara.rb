require 'rails_helper'
feature "image gallery project" do
	
	scenario "successful login and check porofile" do 
		visit root_path
		click_link "Login"
		fill_in "email", with: "nabil@gmail.com"
		fill_in "password", with: "12345"
		click_button "Submit"
		visit "/users/:id"

		# page.should have_content "Successfully Login"
	end




end