require "puzzle_maker/version"

module PuzzleMaker
  class SimpleCrossword

    attr_reader :available_answers, :result

    def initialize(result:, available_answers:)
      @result            = result
      @available_answers = available_answers
    end

    def generate
      self
    end

    def selected_answers
      return [] if available_answers.empty?
      [available_answers.first] if available_answers.first.include? result
    end
  end
end
