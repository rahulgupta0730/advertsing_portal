class Slot < ApplicationRecord
	belongs_to :provider, class_name: 'User', foreign_key: 'provider_id'
	# has_one :organization, class_name: 'User', foreign_key: 'organization_id'
	# has_one :agent, class_name: 'User', foreign_key: 'agent_id'
  validates_presence_of :start_time ,:end_time ,:base_price
  validates :base_price, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 } , :on => :create
  before_save :date_time_format
  validate :time_overlaps ,  :on => :create



  def date_time_format
  	if !self.start_time.blank?
  		self.start_time = self.start_time.to_datetime
  	end
  	if self.end_time.blank?
  		self.end_time = self.end_time.to_datetime
  	end
  end


  def time_overlaps
    if !self.end_time.blank? && !self.start_time.blank?
      if self.end_time < self.start_time
        errors.add(:end_time, "End time cannot be greater than start time")
      else
      	slots =  Slot.where(:provider_id => self.provider_id)
      	slots.each do |slot|
      		if (self.start_time..self.end_time).overlaps?(slot.start_time..slot.end_time)
      			errors.add(:base, "This slot is overlaps with start time "+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M'))
      		end
      	end
      end
    end
  end
end
