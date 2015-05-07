require_relative 'contact_list'
class Contact
 
  attr_accessor :name, :email, :phone_numbers
  @@count = 0

  def initialize(args)
    @@count += 1
    @id = @@count
    @name = args.shift
    @email = args.shift
    @phone_numbers = ""
    @phone_numbers = args.shift if !args.empty?
    ContactList.new
  end
 
  def to_s
    if !@phone_numbers.empty? 
      #chomp to remove last comma off list of phone numbers
      "#{@id} :  #{@name} (#{@email})  #{@phone_numbers}".chomp(", ") 
    else
      "#{@id} :  #{@name} (#{@email})"
    end
  end

  def add_num(args)
      @phone_numbers << args
      ContactList.update(@id-1, @phone_numbers)
  end
 
  ## Class Methods
  class << self
    
    def check_new_contact?(new_info)
      if !new_info[1].include?("@") || !new_info[1].include?(".") #checks email
        puts "Invalid Email" 
        return nil
      end 
      ContactList.contacts.each do |contact|  #checks for duplicated emails
        if contact.include?(new_info[1])
          puts "duplicate contact"
          return nil 
        end
      end
      true
    end

    def create(args)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      #if check_new_contact?(args)
        john_doe = Contact.new(args)
        ContactList.add(john_doe)
        return ContactList.contacts.length #returns the last id added
      #end
    end

    def help
      puts open("help.txt", 'r').readlines
    end

    def find_index(index)
      ContactList.contacts[index.to_i - 1]
    end
 
    def find(index)
      #Will find and return the contacts soft matching the query
      ContactList.contacts.select { |contact| contact.to_s.include?(index) }.each { |contact| puts contact.to_s }
    end
 
    def all
      # TODO: Return the list of contacts, as is
      ContactList.contacts.each { |contact| puts contact.to_s }
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      puts ContactList.contacts[id - 1].to_s # [-1] bc started counting at 1
    end

    def close
      ContactList.close
    end
    # helper method for rspec
    def clear
      ContactList.clear
    end
 
  end
 
end