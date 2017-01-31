require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
before(:each) do 
	@user = User.create!(email: "spec@test.com", password: "testtest")

end
describe "creation" do 
	it "should have one item created " do 
		expect(User.all.count).to eq(1)
end
end

describe "vilidations email should be presence" do
	it "should show an error" do
	@user.email = nil
	expect(@user).to_not be_valid		
		end

		it "should not user been created without a password" do
			@user.password = nil
			expect(@user).to_not be_valid
		end

	describe User do
  it "should have a unique email" do
    User.create!(:email=>"nabil@test.com", :password =>"test")
    user = User.new(:email=>"nabil@test.com", :password =>"test")
    user.should_not be_valid
    user.errors[:email].should include("has already been taken")
  end 
	end

	end 
end
