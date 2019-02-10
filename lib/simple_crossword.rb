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
          if answer.index(letter_of_result)
            @selected_answers << SelectedAnswer.new(answer, letter_of_result)
            @available_answers = available_answers - [answer]
          end
        end
      end

      raise SolutionNotFoundError if result_as_array.count != selected_answers.count
    end

    def width
      biggest_left_offset = selected_answers.map(&:left_offset).max
      biggest_right_offset = selected_answers.map(&:right_offset).max
      biggest_left_offset + biggest_right_offset + 1
    end

    def result_as_array
      result.scan(/\w/)
    end

  end

  class SelectedAnswer

    attr_reader :word, :matching_letter

    def initialize(word, matching_letter)
      @word = word
      @matching_letter = matching_letter
    end

    def length
      @word.length
    end

    def left_offset
      word.index(matching_letter)
    end

    def right_offset
      length - left_offset - 1
    end

  end

  class SolutionNotFoundError < StandardError; end
end
