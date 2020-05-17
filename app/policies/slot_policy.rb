class SlotPolicy < ApplicationPolicy

  def add?
    user.role_name == 'provider'
  end

  def create?
    user.role_name == 'provider'
  end

  def agent_pre_booked?
  	user.role_name == 'agent'
  end


  def binding_amount?
  	user.role_name == 'organization'
  end


end
