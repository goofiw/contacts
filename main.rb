require_relative 'contact'
require_relative 'number'

class InvalidID < StandardError
end

def get_new_contact_info  
  puts "enter your first name"
  firstname = STDIN.gets.chomp
  puts "enter your last name"
  lastname = STDIN.gets.chomp
  puts "enter your email"
  email = STDIN.gets.chomp
  { firstname: firstname, lastname: lastname, email: email }
end

def get_update_params
  puts "Please enter a contact id"
  id = STDIN.gets.chomp
  contact = Contact.find(id)
  raise InvalidID if contact == nil
  puts "what would you like to update (firstname, lastname, or email)?"
  column = STDIN.gets.chomp
  puts "and set it to what"
  set = STDIN.gets.chomp
  { instance: contact, column: column, set: set }
end


def get_phone_number
	puts "enter the number type"
	num_type = STDIN.gets.chomp
	puts "enter the number"
	num = STDIN.gets.chomp
  { numtype: num_type, num: num }
end

# Object#send converst the first argument to a method and subsequent elements to arguments
#see help
if ARGV[0] == "new"
	new_contact = get_new_contact_info
  Contact.new(new_contact).save
elsif ARGV[0] == "update"
  args = get_update_params
  Contact.update(args).save
elsif ARGV[0] == "find"
  puts Contact.send(ARGV[0], ARGV[1]).inspect
elsif ARGV[0] == "destroy"
  Contact.find(ARGV[1]).send(ARGV[0])
elsif ARGV[0] == "last_name"
  puts Contact.find_all_by_lastname(ARGV[1])
elsif ARGV[0] == "first_name"
  puts Contact.find_all_by_firstname(ARGV[1])
elsif ARGV[0] == "email"
  puts Contact.find_by_email(ARGV[1])
elsif ARGV[0] == "add_num"
  Number.new(get_phone_number.merge({ contact_id: ARGV[1] })).save
elsif ARGV[0] == "get_numbers"
  puts Number.get_nums(ARGV[1])
else
	Contact.help
end
  

 
