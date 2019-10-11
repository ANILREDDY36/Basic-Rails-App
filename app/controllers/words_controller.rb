# frozen_string_literal: true

# WordsController
class WordsController < ApplicationController
  def index
    @words = Word.all
  end
end
