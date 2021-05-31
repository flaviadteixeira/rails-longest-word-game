require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = [*'A'..'Z'].sample(10)
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_finder = URI.open(url).read
    word_validate = JSON.parse(word_finder)

    if word_validate['found'] == true && word_checker(@word)
    @result = "Congratulations! #{@word.upcase} is a valid English word!"

    else
    @result = "Sorry but #{@word.upcase} does not seem to be a valid English word.."
    end


  end

  private

  def word_checker(word)
    new_word = @word.chars
    @newv = params["letters"].downcase.split(" ")
    @valid_word = new_word.all? { |letter| @newv.include?(letter) }
    return @valid_word
  end

end
