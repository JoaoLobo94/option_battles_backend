class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :set_user, only: [:show, :update, :get_balance, :withdraw]

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
    }, status: :accepted
    else
      render json: { message: @user.errors.full_messages }, status: :not_acceptable
    end
  end

  def update
    @user.update(game_id: user_params[:game_id], lnurl: user_params[:lnurl])
    render json: @user, status: 200
  end

  def get_balance
    @user = User.find_by(username: user_params[:username])
    render json: @user.balance, status: 200
  end

  def withdraw
    if @user.withdraw(user_params[:bolt11]) == "Insufficient funds"
      render json: { message: "Insufficient funds" }, status: 400
    else
      render json: @user, status: 200
    end
  end

  private
  def set_user
    @user = User.find_by(username: user_params[:username])
  end

  def user_params
    params.permit(:game_id, :lnurl, :username, :password, :bolt11)
  end
end