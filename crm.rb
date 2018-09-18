require './contact.rb'

class CRM

  def initialize

  end

  def main_menu
    while true # repeat indefinitely
      puts "\e[H\e[2J"
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit(true)
    end
    puts "Press any key to continue"
    gets.chomp
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )

  end

  def modify_existing_contact
    print "Enter the attribute you wish to search by "
    user_input_attribute = gets.chomp

    print "Enter the value of the attribute to search by "
    user_input_value = gets.chomp

    print "Which attributes would you like to modify"
    user_input_new_attributes = gets.chomp.split(' ')

    print "New values of the attributes"
    user_input_new_values = gets.chomp.split(' ')

    ##create hash
    update_hash = Hash[user_input_new_attributes.zip user_input_new_values]
    puts update_hash

    item_to_modify =  Contact.find_by(user_input_attribute, user_input_value)
    item_to_modify.update(update_hash)


  end

  def delete_contact
    print "Enter the attribute you wish to search by "
    user_input_attribute = gets.chomp

    print "Enter the value of the attribute "
    user_input_value = gets.chomp

    item_to_delete = Contact.find_by(user_input_attribute, user_input_value)

    if(item_to_delete)
      item_to_delete.delete
      puts "Delete Successful"
    else
      puts "Could not delete contact"
    end
  end

  def display_all_contacts
    Contact.all.each do |contact|
      display_contact(contact)
    end
  end

  def search_by_attribute
    print "Enter the attribute you wish to search by "
    user_input_attribute = gets.chomp

    print "Enter the value of the attribute "
    user_input_value = gets.chomp

    display_contact(Contact.find_by(user_input_attribute, user_input_value))
  end

  def display_contact(contact)
    if(contact)
      puts "-------------------------------"
      puts "First Name: #{contact.first_name}"
      puts "Last Name: #{contact.last_name}"
      puts "Email : #{contact.email}"
      puts "Notes: #{contact.note}"
      puts "-------------------------------"
    end
  end

end

##initialize Array
#Contact.create('Joe', 'Smith', 'JoeSmith@gmail', 'SHEHEHE')
#Contact.create('Bob', 'Dad', 'BobDad@gmail', 'SHEHEHE')
#Contact.create('Dave', 'Solo', 'DaveSolo@gmail', 'SHEHEHE')
#Contact.create('Randy', 'Victor', 'RandyVictor@gmail', 'SHEHEHE')
#Contact.create('USMA', 'Rage', 'Usma_Rage@gmail', 'SHEHEHE')

my_crm = CRM.new
my_crm.main_menu

at_exit do
  ActiveRecord::Base.connection.close
end
