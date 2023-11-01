class GamesController < ApplicationController
  before_action :set_game, except: [:index]
  def index
    @games = Game.all

    render json: @games, status: 200
  end

  def create
    @game = Game.new(game_params)
    @user = User.find_by(npub: game_params[:npub])
    if @game.save
      @user.update(game_id: @game.id, looking_for_game: false)
    end

    render json: @game, status: 201
  end

  def update
    @game.update(game_params[:winner])

    render json: @game, status: 200
  end

  def index_game_users
    render json: @users, status: 200
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
    @users = @game.users
  end

  def game_params
    params.permit(:amount, :winner, :npub)
  end
end