module Authentication
  extend ActiveSupport::Concern
   
  included do
    attr_accessor :remember_token
  end
  
  # Because of the way Ruby handles assignments inside objects, 
  # without self the assignment would create a local variable 
  # called remember_token, which isn’t what we want. 
  # Using self ensures that assignment sets the user’s 
  # remember_token attribute.
  def remember
    self.remember_token = self.class.new_token
    # update_attribute skips validation
    update_attribute(:remember_digest, self.class.digest(remember_token))
  end
  #
  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  module ClassMethods

    # Returns the hash digest of the given string.
    def digest(string)        # Could also be self.digest
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end 
end
