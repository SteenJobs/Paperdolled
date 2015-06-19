class OutfitsController < ApplicationController
  def new
    @item = Item.all
  end
end
