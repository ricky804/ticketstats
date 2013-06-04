class Team
  attr_accessor :name, :players

  def initialize(name, players = [])
    raise Exception unless players.is_a? Array
    raise Exception if @name && has_bad_name
    @name = name
    @players = players
  end

  def has_bad_name
    list_of_words = %w{crappy bad lousy}
    list_of_words.include? @name.downcase.split(" ") != list_of_words
  end

  def favored?
    @players.include? "Ricky"
  end

end
