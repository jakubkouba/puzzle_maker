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

      @selected_answers = [SelectedAnswer.new(available_answers.first)] if available_answers.first.include? result
      @selected_answers
    end
  end

  class SelectedAnswer

    attr_reader :word

    def initialize(word)
      @word = word
    end

    def length
      @word.length
    end

    def match_position
      1
    end
  end
end
