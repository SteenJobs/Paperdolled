class UsersController < ApplicationController
  respond_to :json, :html
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
