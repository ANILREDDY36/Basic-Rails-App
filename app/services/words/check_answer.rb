module Words
  class CheckAnswer

    def initialize(word, game, answer)
      @word = word
      @game = game
      @answer = answer
    end
    def call
      check_answer
    end
  
    private

    attr_reader :word, :answer


    def check_answer
      if good_answer?
        update_game_stats(success: true)
      else
        update_game_stats(success: false)
      end
    end

    def good_answer?
      Word.translations.where(content: answer).exists?
    end

    def update_game_stats(success:)
      return game.increment!(:good_answer_count) if success == true
      game.increment!(:bad_answer_count)
    end
  end
end
