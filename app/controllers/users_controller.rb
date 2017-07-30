class UsersController < ApplicationController
  include UsersHelper

  def index
    @users = User.all
    render json: {users: @users}.as_json, status: 201
  end

  def notify_users
    epicenter = [params[:lat].to_i, params[:long].to_i]
    severity = params[:severity]
    @users = alert_users(epicenter, severity)

    render json: {users: @users}.as_json, status: 201
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: {user: @user, location: @user.location}.as_json, status: 201
  end

  def update_status
    @user = User.find_by(id: params[:id])
    if @user
      @user.update_attribute(:status, params[:status])
    end
    render json: {user:@user}.as_json, status: 201
  end

  def update_location
    @user = User.find_by(id: params[:id])
    if @user
      @user.update_attribute(:longitude, params[:long])
      @user.update_attribute(:latitude, params[:lat])
    end
    render json: {location:@user.location}.as_json, status: 201
  end

  private
  EARTH_RADIUS = 3961

  def alert_users(epicenter, severity)
    affected_users = []
    User.find_each do |user|
      if distance(epicenter, user.location) < radius_affected(severity)
        affected_users << user
      end
    end

    affected_users.each do |user|
      change_status(user, "pending")
    end
    return affected_users
    
  end

  def radius_affected(severity)
    case severity
    when "moderate"
      return 3
    when "severe"
      return 5
    end
  end

  def distance(epicenter,user_location) #gets distance between two points (in miles)
    d_longitude = toRadians((epicenter[1]-user_location[1]))
    d_latitude = toRadians((epicenter[0]-user_location[0]))

    sin_d_long = Math.sin(d_longitude)
    sin_d_lat = Math.sin(d_latitude)

    rad_epi_lat = toRadians(epicenter[0])
    rad_user_lat = toRadians(epicenter[1])

    a = sin_d_lat ** 2 + Math.cos(rad_epi_lat) * Math.cos(rad_user_lat) * (sin_d_long ** 2)
    c = Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    return EARTH_RADIUS * c
  end

  def change_status(user, status)
    user.update_attribute(:status, status)
  end

  def toRadians(degrees)
    return degrees * Math::PI / 180
  end

end
