require_relative 'contact'
def get_new_contact_info  
  puts "enter your first name"
  firstname = STDIN.gets.chomp
  puts "enter your last name"
  lastname = STDIN.gets.chomp
  puts "enter your email"
  email = STDIN.gets.chomp
  return {firstname: firstname, lastname: lastname, email: email}
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
  Contact.new(new_contact)
elsif ARGV[0] == "list"
  #Contact.all
elsif ARGV[0] == "show"
	#Contact.send(ARGV[0], ARGV[1].to_i)
elsif ARGV[0] == "find"
  Contact.send(ARGV[0], ARGV[1])
elsif ARGV[0] == "destroy"
  Contact.find(ARGV[1]).send(ARGV[0])
else
	#Contact.send(ARGV[0])
end
  

 
