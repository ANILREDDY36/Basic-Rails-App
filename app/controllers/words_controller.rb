# frozen_string_literal: true

# WordsController
class WordsController < ApplicationController
  before_action :set_word, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  def index
    @words = Word.all.page params[:page]
  end

  def new
    @word = current_user.words.build
  end

  def create
    @word = current_user.words.build(word_params)
    @word.translations.each do |translation|
      translation.user = current_user
    end
    if @word.save
      redirect_to(words_path)
    else
      render :new
    end
  end

  def show; end

  def edit
    authorize @word
  end

  def update
    authorize @word
    if @word.update(word_params)
      redirect_to(word_path(@word))
    else
      render :edit
    end
  end

  def destroy
    authorize @word
    if @word.destroy
      redirect_to(words_path)
    else
      render :index
    end
  end

  private

  def word_params
    params.require(:word).permit(:content,
      :language_id,
      translations_attributes: [:id, :content, :language_id, :_destroy]
    )
  end

  def set_word
    @word = Word.find(params[:id])
  end
end
