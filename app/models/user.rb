require 'digest'

class User < ActiveRecord::Base  
  #Dependencies
  has_one :profile, dependent: :destroy

  
  has_many :defaults, :through => :profile, :source => :config, :source_type => "Profile"

  
  has_many :models, dependent: :destroy
  
  
  
  #Validation
  validates_uniqueness_of :email
  validates_length_of :email, :within => 5..50
  validates_format_of :email, :multiline => true, :with =>  /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i
  
  validates_confirmation_of :password
  validates_length_of :password, :within => 4..20
  validates_presence_of :password, :if => :password_required?
  
  #Callbacks
  before_save :encrypt_new_password
  
  #Methods
  attr_accessor :password
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end
  
  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end
	
	protected
	  def encrypt_new_password
	    return if password.blank?
	    self.hashed_password = encrypt(password)
	  end
	  
	  def password_required?
	    hashed_password.blank? || password.present?
	  end
	  
	  def encrypt(string)
	    Digest::SHA1.hexdigest(string)
	  end
end
