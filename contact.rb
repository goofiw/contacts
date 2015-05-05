class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_s
    # TODO: return string representation of Contact
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      ContactList.contacts.each do |contact|
        return nil if contact.include?(email)
      end
      john_doe = Contact.new(name, email)
      ContactList.add(john_doe)
      john_doe
    end
 
    def find(index)
      # TODO: Will find and return contact by index
      ContactList.contacts.each do |contact|
        return contact if contact.detect{ |email| email }
      end
    end
 
    def all
      # TODO: Return the list of contacts, as is
      ContactList.contacts
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      puts ContactList.contacts[id]
    end

    def close
      ContactList.close
    end

    def clear
      ContactList.clear
    end

    
  end
 
end