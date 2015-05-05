## TODO: Implement CSV reading/writing
require 'csv'

class ContactsDatabase

	def self.load_contacts
	   CSV.read("contacts.csv")
	end

	def self.save_contacts(contacts)
		CSV.open("contacts.csv", 'w') do |table|
			contacts.each do |row|
        table << row
      end
    end
	end
end