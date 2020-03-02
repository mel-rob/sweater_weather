class Api::V1::MunchiesController < ApplicationController

  def show
    render json: MunchieSerializer.new(Munchie.new(params[:start], params[:end], params[:food]))
  end
end
