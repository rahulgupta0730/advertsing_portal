class User < ApplicationRecord
  attr_accessor :password
  validates_presence_of :fname ,:lname ,:password , :password_confirmation, :email , :role_name
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_length_of :password, in: 6..15
  validates_confirmation_of :password , :email
  before_save :downcase_email ,:encrypt_password

  def downcase_email
    self.email = self.email.downcase.strip
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password , password_salt)
    end
  end
  
  def authenticate(password)
    if self && self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
      return true
    else
      return false
    end
  end



  def slot_available
    if self.role_name == "provider"
      slots =  Slot.where(:provider_id => self.id).order("id DESC")
    elsif self.role_name == "agent"
      slots =  Slot.where(:status => "available" ,:agent_id => nil).order("id DESC")
    elsif self.role_name == "organization"
      slots = Slot.where(:status => ["available" , "biding_start"]).where.not(:agent_id => nil).order("id DESC")
    end
  end


  def user_specific
    if self.role_name == "agent"
      slots =  Slot.where(:agent_id => self.id).order("id DESC")
    elsif self.role_name == "organization"
      slots =  Slot.where(:organization_id => self.id).order("id DESC")
    end
  end


  def biders(slot_id)
    slot = Slot.find(slot_id)
    biders = Biding.where(:slot_id => slot_id).where.not(:bid_by => self.id).pluck(:bid_by)
    if !biders.blank?
      biders.each do |bider|
        ApplicationMailer.bid_rate(slot_id, bider , self.id ).deliver_later
      end
    end
    ApplicationMailer.bid_rate(slot_id,slot.agent_id , self.id).deliver_later
  end


  def sold_email(slot_id)
    slot =  Slot.find(slot_id)
    biders = Biding.where(:slot_id => slot.id).where.not(:bid_by => slot.organization_id).pluck(:bid_by)
    if !biders.blank?
      biders.each do |bider|
        ApplicationMailer.bid_loser(slot_id,bider).deliver_later
      end
    end
    ApplicationMailer.bid_winner(slot_id,slot.organization_id).deliver_later
    ApplicationMailer.provider_sold_confirmation(slot_id,slot.provider_id).deliver_later
  end

  def name
    return self.fname+" "+self.lname
  end
end