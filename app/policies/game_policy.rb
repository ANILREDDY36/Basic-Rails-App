class GamePolicy
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end

  def show?
    user_game?
  end

  private

  def user_game?
  	user == game.user
  end
end
