require_relative 'contact'
def get_new_contact_info  
  puts "enter your full name"
  name = STDIN.gets.chomp
  puts "enter your email"
  email = STDIN.gets.chomp
  return [name, email]
end

def get_phone_number
	puts "enter the number type"
	type = STDIN.gets.chomp
	puts "enter the number"
	number = STDIN.gets.chomp
  "#{type}: #{number} "
end

# Object#send converst the first argument to a method and subsequent elements to arguments

if ARGV[0] == "new"
	new_contact = get_new_contact_info
  Contact.create(new_contact)
elsif ARGV[0] == "list"
  Contact.all
elsif ARGV[0] == "show"
	Contact.send(ARGV[0], ARGV[1].to_i)
elsif ARGV[0] == "find" 
  Contact.send(ARGV[0], ARGV[1])
elsif ARGV[0] == "add_num"
	num = get_phone_number
  Contact.find_index(ARGV[1]).add_num(num)
else
	Contact.send(ARGV[0])
end
  

 
