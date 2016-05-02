class SistemasController < ApplicationController
	before_action :authenticate_persona!
  def index
    authorize self
  end
  def logs
  end
  def icfes
  end
end  
