class EvaluadoresController < ApplicationController
  before_action :authenticate_persona!
  def index?
    authorize self
  end
end
