class ScenariosController < ApplicationController
  def new
    @scenario = Scenario.new
  end
end
