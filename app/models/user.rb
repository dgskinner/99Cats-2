class User < ActiveRecord::Base
  validates :user_name, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: {minimum: 6, allow_nil: true}
  
  validates :session_token, presence: true
  after_initialize :ensure_session_token
  
  has_many :cats
  
  has_many :demands, through: :cats, source: :cat_rental_requests
  
  has_many(
    :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many :sessions
  
  def logged_in?
    !self.sessions.nil?
  end
  
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user.try(:is_password?, password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
 
end
