class UsersController < ApplicationController

  def index
    @users = []
    User.find_each do |user|
       if distance([0,0],user.location) < 5 #replace [0,0] with epicenter
         @users << user
       end
    end
    @users.each do |user|
      change_status(user, "safe")
    end
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
      @user.update_attribute(:longitude, params[:x])
      @user.update_attribute(:latitude, params[:y])
    end
    render json: {location:@user.location}.as_json, status: 201
  end

  private

  def distance(epicenter,user_location)
    p user_location
    delta_x = (epicenter[0]-user_location[0])
    delta_y = (epicenter[1]-user_location[1])
    return Math.sqrt(delta_y**2 + delta_x**2)
  end

  def change_status(user, status)
    user.status = status
  end
end
