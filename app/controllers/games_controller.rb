# frozen_string_literal: true

# WordsController
class GamesController < ApplicationController
  # before_action :set_game, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[show create]

  def index
    
  end

  def create
    game = current_user.games.create
    redirect_to(game)
  end

  def show
    @game = Game.find(params[:id])
    authorize @game
    @word = Words::RandomWord.new.call
  end
end  