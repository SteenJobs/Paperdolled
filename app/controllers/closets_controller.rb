class ClosetsController < ApplicationController
  def create
    @outfit = current_user.outfits.create
    @outfit_id = @outfit.id
    params["object"].each do |key, value|
      Closet.create(outfit_id: @outfit_id, item_id: value[:item_id], x_coordinate: value[:x_coordinate], y_coordinate: value[:y_coordinate], height: value[:height], width: value[:width])
    end
  
    
    if @outfit.save
      flash['notice'] = "Outfit created!" # Check color
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.json { render :json => {
                  :location => url_for(:controller => 'users', :action => 'show', :id => current_user.id),
                  :flash => {:notice => "Outfit created!"}
                }
              }
      end
    else
      render 'new'
    end
  end
end
