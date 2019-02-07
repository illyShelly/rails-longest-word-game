require "open-uri"

class GamesController < ApplicationController
  LETTERS = (('a'..'z').to_a)

  def new
    # array of range a-z into array
    # randomly chosen from 26 letters
    # how many? -> map new array (6.times)
    # random letters stored in @letters variable
    @letters = 8.times.map { LETTERS[rand(26)] }
  end

  def score
    # from post method form name="answer"
    # raise
    # !!! is string from params -> need array again
    @letters = params[:letters].split
    @word = (params[:answer] || "").downcase
    # store in variable -> return value from method included?
    @included = included?(@word, @letters)
    # if correct every char from answer were generated as well
    @english_word = english_word?(@word)
  end

  # method answer included in the wagon-dictionary
  def included?(word, letters)
    # all? return true only if all letters in array are true
    word.chars.all? { |char| word.count(char) <= letters.count(char) }
  end

  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    # if true?
    return json["found"]
  end
end

# {
#   "found": true,
#   "word": "apple",
#   "length": 5
# }

# The new action will be used to display a new random grid and a form. The form will be submitted (with POST) to the score action.
