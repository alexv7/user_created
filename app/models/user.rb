class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  # validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
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
