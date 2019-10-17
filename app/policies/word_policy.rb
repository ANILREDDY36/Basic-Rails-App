class WordPolicy
  attr_reader :user, :word

  def initialize(user, word)
    @user = user
    @word = word
  end

  def edit?
    user_word?
  end

  def update?
    user_word?
  end

  def destroy?
    user_word?
  end

  private

  def user_word?
  	user == word.user
  end
end