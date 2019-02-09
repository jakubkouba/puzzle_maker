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
      if available_answers.empty?
        @selected_answers = []
        return @selected_answers
      end

      matching_positon = available_answers.first.index(result)
      @selected_answers = [SelectedAnswer.new(available_answers.first, matching_positon)] if matching_positon
      @selected_answers
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
end
