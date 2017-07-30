module UsersHelper


  def affected_users(epicenter, severity)
    User.find_each do |user|
     if distance([0,0],user.location) <  #replace [0,0] with epicenter
       @users << user
     end
   end
  end

  private
  def distance(epicenter,user_location)
    p user_location
    delta_x = (epicenter[0]-user_location[0])
    delta_y = (epicenter[1]-user_location[1])
    return Math.sqrt(delta_y**2 + delta_x**2)
  end

  def radius_affected(severity)
    case severity
    when "minor"
      return 1
    when "medium"
      return 2
    when "major"
      return 3
    end
  end

  def event_epicenter
  end
end
