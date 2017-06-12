class HangpersonGame 

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @wrong_chances = 0
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter.empty?
    raise ArgumentError if letter =~ /[^a-zA-Z]+/
    letter.downcase!
    g = @guesses.include?(letter)
    ng = @wrong_guesses.include?(letter)
    if g or ng
      return false 
    elsif @word.include? (letter)
      @guesses << letter
      return true 
    else
      @wrong_guesses << letter
      @wrong_chances += 1
      return true
    end 
  end 
  
  def word_with_guesses
    output = ''
    @word.split("").each do |letter|
      if @guesses.include? letter 
        output << letter
      else
        output << '-'
      end 
    end 
    return output
  end 
  
  def check_win_or_lose
    if (@guesses.length == @word.length) and @wrong_chances < 7
      return :win 
    elsif @wrong_chances >= 7
      return :lose
    else 
      return :play 
    end 
  end 
end 