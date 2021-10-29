class CalculationsController < ActionController::API

  def calculate
    result = CalculatePValue.new(params[:control_sends], params[:test_sends], params[:control_converted], params[:test_converted]).perform
    @significance = { significance: result}

    render json: @significance
  end
end