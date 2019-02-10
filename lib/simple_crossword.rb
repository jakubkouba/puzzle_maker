require "puzzle_maker/version"
require 'byebug'

module PuzzleMaker
  class SimpleCrossword

    attr_reader :available_answers, :result, :selected_answers

    def initialize(result:, available_answers:)
      @result            = result
      @available_answers = available_answers
      @selected_answers = nil
    end

    def generate
      select_answers
      self
    end

    def select_answers
      @selected_answers = []
      return if available_answers.empty?

      result_as_array.each do |letter_of_result|
        available_answers.each do |answer|
          if matching_position = answer.index(letter_of_result)
            @selected_answers << SelectedAnswer.new(answer, matching_position)
            @available_answers = available_answers - [answer]
          end
        end
      end

      raise SolutionNotFoundError if result_as_array.count != selected_answers.count
    end

    def result_as_array
      result.scan(/\w/)
    end

  end

  class SelectedAnswer

    attr_reader :word, :matching_position

    def initialize(word, matching_position)
      @word = word
      @matching_position = matching_position + 1
    end

    def length
      @word.length
    end
  end

  class SolutionNotFoundError < StandardError; end
end
