require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String
  property :email,  String,  :required => true, :unique => true,
  :format   => :email_address,
  :messages => {
                :presence  => "We need your email address.",
                :is_unique => "We already have that email.",
                :format    => "Doesn't look like an email address to me ..."
                }




  property :password_digest,   Text


  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
