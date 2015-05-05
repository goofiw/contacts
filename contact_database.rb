## TODO: Implement CSV reading/writing
require 'csv'
require_relative 'contact'
class ContactsDatabase

	def self.load_contacts
	   CSV.read("contacts.csv")
	end

	def self.save_contacts(contacts)
		CSV.open("contacts.csv", 'w') do |table|
			contacts.each do |contact|
           table << [contact.name, contact.email, contact.phone_numbers]

      end
    end
	end
end