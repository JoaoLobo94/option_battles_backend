class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :add_user_to_game]

  def show
    render json: @user, status: 200
  end

  def create
    @user = User.new(user_params)
    @user.save
    render json: @user, status: 201
  end

  def update
    @user.update(game_id: user_params[:game_id], lnurl: user_params[:lnurl], game_amount: user_params[:game_amount],
                 looking_for_game: user_params[:looking_for_game])
    render json: @user, status: 200
  end

  def add_user_to_game
    User.looking_for_same_game(user_params[:game_amount]).sample.update(game_id: user_params[:game_id], looking_for_game: false)

    render json: @user, status: 200
  end

  private
  def set_user
    @user = User.find_by(npub: user_params[:npub])
  end

  def user_params
    params.permit(:game_id, :lnurl, :npub, :game_amount, :looking_for_game)
  end
end