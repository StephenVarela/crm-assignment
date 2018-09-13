require 'pry'
class Contact

  @@contacts = []
  @@id = 1
  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    @id = @@id
    @@id += 1
  end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    new_contact = self.new(first_name, last_name, email, note)
    @@contacts << new_contact
    return new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    return @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    @@contacts.each do |contact|
      if(contact.id == id)
        return contact
      end
    end
    puts "did not find contact"
    return nil
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty

  def self.find_by(attribute, value)
    valid_attributes = ['first_name', 'last_name', 'email', 'notes']

    if(valid_attributes.include?(attribute))
      @@contacts.each do |contact|
        if(contact.send(attribute) == value)
          return contact
        end
      end
      puts "Could not find contact by specified attribute"
      return nil
    else
      puts "Invalid Attribute"
      return nil
    end
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts.clear
  end


  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(update_hash)
    update_hash.each do |key, value|
      if(key == 'first_name')
        self.first_name = value
      end
      if(key == 'last_name')
        self.last_name = value
      end
      if(key == 'email')
        self.email = value
      end
      if(key == 'notes')
        self.note = value
      end
    end
  end



  def full_name
    puts "Full name: #{first_name} #{last_name}"
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete
    @@contacts.delete(self)
  end

  # Feel free to add other methods here, if you need them.

  ##Getter
  def first_name
    return @first_name
  end

  def last_name
    return @last_name
  end

  def email
    return @email
  end

  def note
    return @note
  end

  def id
    return @id
  end
  #setter

  def first_name=(first_name)
    @first_name = first_name
  end

  def last_name=(last_name)
    @last_name = last_name
  end

  def email=(email)
    @email = email
  end

  def note=(note)
    @note = note
  end



end
