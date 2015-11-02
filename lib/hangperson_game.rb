class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  
  
  def initialize(word)
    @attempt = 0
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = ""
    @word.chars.each do |l| 
      @word_with_guesses += "-"
    end
  end
  
  def guess(letter)
    if !(letter =~ /^[a-zA-Z]+$/) then
      raise ArgumentError
    end
    low_letter = letter.downcase
    if (@word =~ Regexp.new(low_letter)) then
      if !(@guesses =~ Regexp.new(low_letter)) then 
        @guesses += low_letter 
        for i in 0..@word.length-1
          if (@word[i]==low_letter) then @word_with_guesses[i]=low_letter end
        end
        return true
      end
    else
      if !(@wrong_guesses =~ Regexp.new(low_letter)) then 
        @wrong_guesses += low_letter 
        @attempt += 1
        return true
      end
    end
    return false
  end
  
  def check_win_or_lose()
    if @attempt >= 7 then return :lose end
    if (@word == @word_with_guesses) then return :win end 
    return :play 
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
