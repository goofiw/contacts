require_relative 'contact'
require_relative 'contact_database'


class ContactList
	@@list_initialized = false
  @@contacts = []
  
  def initialize
  	if !@@list_initialized
  		#puts "contacts list initializing"
  		@@list_initialized = true
  	  ContactsDatabase.load_contacts.each { |contact_arr| @@contacts << Contact.new(contact_arr) }
  	  
    else 
    	#puts "list already initialized"
    end
  end
  class << self
	  def add(contact)
	  	@@contacts << contact
	  	save
	  end

	  def update(id, phone_numbers)
       @@contacts[id].phone_numbers = phone_numbers
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