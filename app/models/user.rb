class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  # validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # In case you’re worried that Listing 9.10 might allow new users to sign up
  # with empty passwords, recall from Section 6.3.3 that has_secure_password
  # includes a separate presence validation that specifically catches nil
  # passwords. (Because nil passwords now bypass the main presence validation but
  # are still caught by has_secure_password , this also fixes the duplicate error
  # message mentioned in Section 7.3.3.).
  # Basically what this is doing is that when updating/editing the user attributes, if 
  # the user does not update the password and confirmation fields (leaves it nil)
  # then it will keep its password as the original password that they
  # used when they signed up.


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end

=begin



Expression	Meaning

/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	full regex

/	start of regex

\A	match start of a string

[\w+\-.]+	at least one word character, plus, hyphen, or dot

@	literal “at sign”

[a-z\d\-.]+	at least one letter, digit, hyphen, or dot

\.	literal dot

[a-z]+	at least one letter

\z	match end of a string

/	end of regex

i	case-insensitive

Table 6.1: Breaking down the valid email regex.



=end
