class User < ApplicationRecord

  # Necessary because some DB adapters use case sensitive indices
  # which is not wanted in our application:
  # In our application "foo@bar.com" and "Foo@BAR.com" should be handled as indentical email-adresses
  # ==> We always convert the email to downcase before saving to the DB
  # before_save { self.email = email.downcase }
  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+(\.[a-z]+)?\z/i

  validates :name, presence: true,  length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
                    # uniqueness: {case_sensitive: false} ## not necessary anymore bc. case-sensitive matching works fine is all emails are lower case already

  # In order to make 'has_secure_password' do its magic
  # we have to add the necessary 'password_digest' attibute to the DB via:
  #
  #    rails generate migration add_password_digest_to_users password_digest:string
  #           # => db/migrate/*_add_password_digest_to_users.rb
  #
  #
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

end
