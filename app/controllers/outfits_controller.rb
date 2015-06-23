class OutfitsController < ApplicationController
  def new
    @outfit = current_user.outfits.new
    @outfit_id = @outfit.id
    @items = Item.all.paginate(:page => params[:page], per_page: 28)
  end  
  
  def create
  end
end
