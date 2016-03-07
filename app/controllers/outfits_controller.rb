

class OutfitsController < ApplicationController
  def new
    #@outfit = current_user.outfits.new
    #@outfit_id = @outfit.id
    @items = Item.all.paginate(:page => params[:page], per_page: 24)
  end  
  
  def show
  	@user = User.find(params[:user_id])
  	@outfit = Outfit.where(styled_id: @user.id, id: params[:id]).first
  	@items = @outfit.nil? ? [] : @outfit.items
  end

  def create
  end

  def destroy
  	user = User.find(params[:user_id])
  	outfit = Outfit.where(styled_id: user.id, id: params[:id]).first
  	authorize! :destroy, outfit
  	outfit.destroy
  	redirect_to user_path(user)
  end

end
