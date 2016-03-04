class AnswersController < ApplicationController
  
  def new
    @answer = Answer.new
  end
  
  def create
    new_scenario = current_user.scenarios.create
    @scenario_id = []
    @scenario_id << new_scenario.id
    params_hash = params.except(:utf8, :authenticity_token, :commit, :event_id, :controller, :action)
    puts params_hash
    params_hash.each do |key, value|
      if !value.blank?
        if key == "answer"
          @type_in = value[:type_in]
          @date = value[:date]
        else
          @type_in = nil
          @date = nil
        end
        Answer.create(option_id: value, scenario_id: @scenario_id[0], type_in: @type_in, date: @date)
      end
    end
    
    if new_scenario.save
      flash['notice'] = "Event updated!" # Check color
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end
  
  
  protected
  
  def answer_params
    params.require(:answer).permit(:id, :option_id2,:option_id3,:option_id4,:option_id5,:option_id6)
  end
end
