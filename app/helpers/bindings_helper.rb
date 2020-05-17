module BindingsHelper
	def highest_bid(solt_id , user_id)
		max_bid = Biding.where(:slot_id => solt_id).order("latest_bid DESC").first
		if !max_bid.blank?
			if max_bid.bid_by == user_id
				return max_bid.latest_bid.to_s+" (by you)"
			else
				return max_bid.latest_bid.to_s
			end
		else
			return "No biding"
		end
	end
end
