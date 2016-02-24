class ItemsController < ApplicationController
  def index
    @items = Item.all.paginate(:page => params[:page])
  end
end
