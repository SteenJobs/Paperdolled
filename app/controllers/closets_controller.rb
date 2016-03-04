require 'pry'
class ClosetsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    styled_id = user.id #params[:object][:styled_id]
    @outfit = Outfit.create(stylist_id: current_user.id, styled_id: styled_id)
    @outfit_id = @outfit.id
    params["object"].each do |key, value|
      Closet.create(outfit_id: @outfit_id, item_id: value[:item_id], x_coordinate: value[:x_coordinate], y_coordinate: value[:y_coordinate], height: value[:height], width: value[:width])
    end
  
    
    if @outfit.save
      flash['notice'] = "Outfit created!" # Check color
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.json { render :json => {
                  :location => url_for(:controller => 'users', :action => 'show', :id => styled_id),
                  :flash => {:notice => "Outfit created!"}
                }
              }
      end
    else
      render 'new'
    end
  end
end
