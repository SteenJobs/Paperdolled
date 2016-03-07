class ItemsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]
  
  def index
    @items = Item.all.paginate(:page => params[:page])
  end
end
