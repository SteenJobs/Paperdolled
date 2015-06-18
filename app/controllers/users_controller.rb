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
    @answer = Answer.new
    @options = Option.all
  end
end
