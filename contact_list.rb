require_relative 'contact'
require_relative 'contact_database'


class ContactList
	@@list_initialized = false
  @@contacts = []
  
  def initialize
  	if !@@list_initialized
  	  @@contacts = ContactsDatabase.load_contacts
    else 
    	puts "list already initialized"
    end
  end
  class << self
	  def add(contact)
	  	@@contacts << [contact.name, contact.email]
	  end

	  def contacts
	  	@@contacts
	  end

	  def close
	  	ContactsDatabase.save_contacts(@@contacts)
	  end

	  def clear
	  	@@contacts = []
	  end
	end
end