module LoginHelper
  def user_type
    users = [
      ["Organisation","organisation"] ,
      ["Provider","provider"] ,
      ["Agent","agent"]
    ]
    return users
  end

end
