class Biding < ApplicationRecord
	belongs_to :organization, class_name: 'User', foreign_key: 'bid_by'
	belongs_to :slot
	validates :latest_bid, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
	validate :bid_price_check
	after_save :biding_start



	def bid_price_check
		if !self.latest_bid.blank?
			if self.slot.base_price >= self.latest_bid
				errors.add(:base, "Please enter the amount greater then base base price")
			end
			max_bid = Biding.where(:slot_id => self.slot_id).order("latest_bid DESC").first
			if !max_bid.blank? && self.latest_bid <= max_bid.latest_bid
				errors.add(:base, "Please enter the amount greater then highest bid price")
			end
		end		
	end

	def biding_start
		bindings =  Biding.where(:slot_id => self.slot_id)
		if bindings.count == 1
			self.slot.status = "biding_start"
			self.slot.save
		end
	end
end
