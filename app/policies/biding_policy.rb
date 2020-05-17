class BidingPolicy < ApplicationPolicy
	
	def biding_end?
		user.role_name == 'agent'
	end

end
