require "puzzle_maker/version"
require 'json'
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

      result_letters.each do |letter|
        available_answers.each do |answer|
          if answer.include?(letter)
            @selected_answers << SelectedAnswer.new(answer, letter)
            @available_answers = available_answers - [answer]
          end
        end
      end

      @selected_answers = [] if result_letters.count != selected_answers.count
    end

    def width
      biggest_left_offset = selected_answers.map(&:left_offset).max
      biggest_right_offset = selected_answers.map(&:right_offset).max
      biggest_left_offset + biggest_right_offset + 1
    end

    def to_json
      return {}.to_json if selected_answers.empty?

      {
        height: height,
        width:  width,
        selected_answers: ['a']
      }.to_json
    end

    def result_letters
      result.scan(/\w/)
    end

    private

    def height
      result.length
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
