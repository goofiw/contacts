require_relative 'contact'
require_relative 'contact_database'


class ContactList
	@@list_initialized = false
  @@contacts = []
  
  def initialize
  	if !@@list_initialized
  	  @@contacts = ContactsDatabase.load_contacts
  	  @@list_initialized = true
    else 
    	puts "list already initialized"
    end
  end
  class << self
	  def add(contact)
	  	@@contacts << [contact.name, contact.email]
	  	save
	  end

	  def contacts
	  	self.new if !@@list_initialized
	  	@@contacts
	  end

	  def save
	  	ContactsDatabase.save_contacts(@@contacts)
	  end

	  def clear
	  	@@contacts = []
	  end
	end
end