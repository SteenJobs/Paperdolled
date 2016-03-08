class UsersController < ApplicationController
  respond_to :json, :html
  
  def index
    if params[:query]
      @users = User.search(params[:query])
    else
      @users = User.all.paginate(:page => params[:page], :per_page => 30)
    end
  end

  def show
    @user = User.find(params[:id])
    @scenario = User.list_answers(@user)
    @answer = Answer.new
    @options = Option.all
    @outfits = Outfit.where(styled_id: @user.id)
    @stylist = User.where(id: @outfits.stylist_id).first
    @disabled = @user == current_user ? false : true
  end
end
