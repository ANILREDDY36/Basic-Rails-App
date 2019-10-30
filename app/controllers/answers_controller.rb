# frozen_string_literal: true

# WordsController
class AnswersController < ApplicationController
  # before_action :set_game, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[create]

  def index

  end

  def create
    checker = words::CheckAnswer.new(word, game, answer).call
    redirect_back(fallback_location: root_path, notice: message(checker))
  end

  private

  def word
    Word.find(params[:answer][:word_id])
  end

  def word
    Game.find(params[:answer][:game_id])
  end

  def answer
    params[:answer][:content]
  end

  def message(checker)
    return 'Good Answer' if checker == true
    'Bad Answer'
  end
end  