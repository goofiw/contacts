require_relative 'contact_list'
require 'pg'


class Contact

    # CONN = PG::Connection.new({
    #   host: 'localhost',
    #   user: 'postgres',
    #   password: 'me',
    #   dbname: 'contacts'
    # })

  #heroku database credentials
  CONN = PG::Connection.new({
      host: 'ec2-50-19-233-111.compute-1.amazonaws.com',
      user: 'gqbdunvbatpemj',
      password: 'FhOIq_g6dCwkjNGiAurFw5z1uN',
      dbname: 'd3uv8jjk4945el'
    })
 
  attr_accessor :name, :email, :phone_numbers

  def initialize(args)
    @id = args[:id] || nil
    puts @id.inspect
    @firstname = args[:firstname]
    @lastname = args[:lastname]
    @email = args[:lastname]
    @phone_numbers = args[:numbers] || ""
  end
 
  def to_s
    if !@phone_numbers.empty? 
      #chomp to remove last comma off list of phone numbers
      "#{@id} :  #{@firstname} #{@lastname} (#{@email})  #{@phone_numbers}".chomp(", ") 
    else
      "#{@id} :  #{@firstname} #{@lastname} (#{@email})"
    end
  end

  def add_num(args)
      @phone_numbers << args
      ContactList.update(@id-1, @phone_numbers)
  end
    #helper methods
        #Contact database methods
  def save
    if is_new?
      result = CONN.exec_params('INSERT INTO contacts (firstname, lastname) VALUES ($1, $2, $3) returning id', 
                                [@firstname, @lastname, @email])
      @id = result[0]['id']
    else
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2 WHERE id = $3', 
                        [@firstname, @lastname, @id])
    end
  end

  def destroy
    CONN.exec_params('DELETE FROM contacts WHERE id = $1', [@id])
  end

    private

    def is_new?
      @id.nil?
    end
 
  ## Class Methods
  class << self

    def help
      puts open("help.txt", 'r').readlines
    end

    def find_index(index)
      ContactList.contacts[index.to_i - 1]
    end
 
    def all
      # TODO: Return the list of contacts, as is
      ContactList.contacts.each { |contact| puts contact.to_s }
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      puts ContactList.contacts[id - 1].to_s # [-1] bc started counting at 1
    end

    def find(id)
      result = nil
      contact = CONN.exec_params('SELECT id, firstname, lastname, email FROM contacts WHERE id = $1', [id])[0]
      result = Contact.new(firstname: contact['firstname'], lastname: contact['lastname'], email: contact['email'], id: contact['id'])
      result
    end

    def find_all_by_lastname(name)
    end

    def find_all_by_firstname(name)
    end

    def find_by_email(email)
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