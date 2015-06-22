class OutfitsController < ApplicationController
  def new
    @items = Item.all.paginate(:page => params[:page], per_page: 28)
  end
end
