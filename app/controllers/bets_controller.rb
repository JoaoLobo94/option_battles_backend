class BetsController < ApplicationController
  def show
    @bet = Bet.find(bet_params[:id])
    render json: @bet, status: 200
  end
  def create
    @bet = Bet.create(amount: bet_params[:amount],
                      bet_type: bet_params[:bet_type],
                      user_id: User.find_by(username: bet_params[:username]).id,
                      start_price: bet_params[:start_price])
    render json: @bet, status: 201
  end
  def update
    @bet = Bet.find_by(id: bet_params[:id])
    @bet.check_for_option_game_winner

    render json: @bet, status: 200
  end
  # implement update for chess to check backend for winner

  private
  def bet_params
    params.permit(:username, :amount, :bet_type, :start_price, :id)
  end
end