class User < ActiveRecord::Base
  validates_presence_of :email, :first_name, :last_name, :hashed_password

  def self.authenticate(email, pwd)
    user = User.where(:email => email).first
    if user
      hash = Digest::SHA2.hexdigest("#{pwd}#{user.salt}")
      user = nil if hash != user.hashed_password
    end
    user
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    if pwd and not pwd.empty?
      self.salt = "salt#{rand}#{Time.now}xiop!"
      self.hashed_password = Digest::SHA2.hexdigest("#{pwd}#{self.salt}")
      @password = pwd
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
end
