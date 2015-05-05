require_relative 'spec_helper'



#JUST FOR PRACTICE
#
#
describe Contact do
	before :all do
		ContactList.clear
		@bob = Contact.create({name: "bob", email: "bob@mail.com"})
		#Contact.close
	end
	it "seeding bob's id and calling name name should be bob" do
		puts @bob.inspect
	  expect(Contact.find(@bob).name).to eql "bob"
	end
		
	it "seeding bob's id and calling email bob's email shoud be bob@mail.com" do
		expect(Contact.find(@bob).email).to eql "bob@mail.com"
	end

	it "shoudl return bob" do
		expect(Contact.find(0)).to eql  ["bob", "bob@mail.com"]
	end

	it "#list Should return a list of all contacts" do
		expect(Contact.list).to eql ["bob", "bob@mail.com"]
	end

	it "Should show the contact when given an ID" do
		expect(Contact.show(0)).to eql ["bob", "bob@mail.com"]
	end
end

#TODO Create a different context with reading from a file