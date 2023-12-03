class BetsController < ApplicationController
  def show
    @bet = Bet.find(bet_params[:id])
    render json: @bet, status: 200
  end
  def create
    @bet = Bet.create(amount: bet_params[:amount],
                      bet_type: bet_params[:bet_type],
                      user_id: User.find_by(username: bet_params[:username]),
                      win_price: bet_params[:win_price])
    render json: @bet, status: 201
  end
  def update
    @bet = Bet.find_by(id: bet_params[:id])
    @bet.check_for_option_game_winner

    render json: @bet, status: 200
  end

  def pay_invoice
    @bet = Bet.find(id: bet_params[:id])
    if @bet.winner
      Lightning.pay_invoice(bet_params[:bolt11])
      @bet.user.update(balance: @bet.user.balance - @bet.amount * 2)
      render json: @bet, status: 200
    else
      render json: @bet, status: 402
    end
  end

  private
  def bet_params
    params.permit(:username, :amount, :bet_type, :win_price, :id, :bolt11)
  end
end