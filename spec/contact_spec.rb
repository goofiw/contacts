require_relative 'spec_helper'

describe Contact do
	before :all do
		ContactList.new
		ContactList.clear
		@bob = Contact.create("bob", "bob@mail")
		Contact.close
	end
	it "bob's name should be bob" do
	  @bob.name == "bob"
	end
		
	it "bob's email shoud be bob@mail" do
		@bob.email == "bob@mail"
	end

	it "shoudl return bob" do
		Contact.find(0) == ["bob", "bob@mail"]
	end

	it "Should return a list of all contacts" do
		Contact.all == ["bob", "bob@mail"]
	end

	it "Should show the contact when given an ID" do
		Contact.show(0) == ["bob", "bob@mail"]
	end
end