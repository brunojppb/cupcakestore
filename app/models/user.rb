class User < ActiveRecord::Base

  before_save { self.email = email.downcase }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  VALID_PHONE_NUMBER_REGEX = /[1-9]{1}[0-8]{1}+-[1-9]{1}[0-9]{3}+-[1-9]{1}[0-9]{3}/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 }, 
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }

  validates :phone_number, presence: true, length: { minimum: 12, maximum: 12 },
                                            format: { with: VALID_PHONE_NUMBER_REGEX }

  validates :password, length: { minimum: 6 }

  has_secure_password


end
