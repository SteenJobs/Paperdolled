class UsersController < ApplicationController
  respond_to :json, :html
  
  def index
    if params[:query]
      @users = User.search(params[:query])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @bios = @user.bio.blank? ? "Describe yourself!" : @user.bio
  end
end
