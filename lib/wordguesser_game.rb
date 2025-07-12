class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    ##TODO
    if letter.nil? || letter=~/[^a-zA-Z]/ || letter.empty? 
      raise ArgumentError
    end

    lowercase_letter = letter.downcase
    if @guesses.include?(lowercase_letter) || @wrong_guesses.include?(lowercase_letter)
      return false
    end

    if @word.include?(lowercase_letter) && !@guesses.include?(lowercase_letter)
      @guesses << letter
    elsif 
      @wrong_guesses << letter
    end
    return true
  end

  def word_with_guesses
    char_arr_w_guesses = @word.chars.map do |char|
    if guesses.include?(char)
      char
    else
      '-'
    end
    end
    char_arr_w_guesses.join
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
