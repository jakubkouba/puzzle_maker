require "puzzle_maker/version"

module PuzzleMaker
  class SimpleCrossword

    def initialize(result:, available_answers:)
      @result            = result
      @available_answers = available_answers
    end

    def generate
      self
    end

    def selected_answers
      []
    end
  end
end
