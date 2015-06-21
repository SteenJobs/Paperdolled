class OutfitsController < ApplicationController
  def new
    @items = Item.all.paginate(:page => params[:page])
  end
end
