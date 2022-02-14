class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    exist = @word.chars.all? { |w| @letters.chars.include?(w) }
    if exist == false
      @answer = "Sorry but #{@word} can't be built out of #{@letters}"
    elsif exist == true && request_api(@word) == false
      @answer = "Sorry but #{@word} does not seem to be an English word..."
    elsif exist == true && request_api(@word) == true
      "<em>Congratulations !</em> #{@word} is a valid English word !"
    end
  end

  def request_api(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json[:found]
  end
end
