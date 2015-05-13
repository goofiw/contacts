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
 
  attr_accessor :name, :email

  def initialize(args)
    @id = args[:id] || nil
    puts @id.inspect
    @firstname = args[:firstname]
    @lastname = args[:lastname]
    @email = args[:lastname]
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
      result = CONN.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) returning id', 
                                [@firstname, @lastname, @email])
      @id = result[0]['id']
    else
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2 WHERE id = $3', 
                        [@firstname, @lastname, @id])
    end
  end

  def update(args)
    instance_variable_set("@#{args[:column]}", args[:set])
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

    def find(id)
      find_by("id", id).nil? ? nil : find_by("id", id)[0]
    end
    #args accepts a :instance of contact, :column for column to update, :set for new assignment
    def update(args)
      args[:instance].instance_variable_set("@#{args[:column]}", args[:set])
      args[:instance]
    end
    
    #private

    def find_by(column, query)
      results = []
      contact = CONN.exec_params("SELECT id, firstname, lastname, email FROM contacts WHERE #{column} = $1", 
                                 [query]).each do |contact|
        results << Contact.new(firstname: contact['firstname'], 
                              lastname: contact['lastname'], 
                              email: contact['email'], 
                              id: contact['id'])
      end
      results.empty? ? nil : results
    end

    def find_all_by_lastname(lastname)
      find_by("lastname", lastname)
    end

    def find_all_by_firstname(firstname)
      find_by("firstname", firstname)
    end

    def find_by_email(email)
      find_by("email", email).nil? ? nil : find_by("email", email)[0]
    end
 
  end
 
end