class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :set_user, only: [:show, :update, :add_user_to_game]

  def show
    render json: @user, status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
    @token = encode_token(user_id: @user.id)
    render json: {
      user: @user,
      token: @token
    }, status: :created
    else
      render json: { message: @user.errors.full_messages }, status: :not_acceptable
    end
  end

  def update
    @user.update(game_id: user_params[:game_id], lnurl: user_params[:lnurl])
    render json: @user, status: 200
  end

  def add_user_to_game
    games = Game.find_or_create_by(amount: user_params[:game_amount], in_progress: false)
    game_to_join = games.sample
    @user.update(game_id: game_to_join.id)

    if game_to_join.users.count == 2
      game_to_join.update(in_progress: true)
      Bet.find_by(user_id: @user.id, game_id: game_to_join.id).update(bet: user_params[:bet])
      render json: 'Let the battle start', status: 200
    else
      render json: 'Waiting for another player', status: 200
    end
  end

  private
  def set_user
    @user = User.find_by(username: user_params[:username])
  end

  def user_params
    params.permit(:game_id, :lnurl, :npub, :bet, :username, :password)
  end
end