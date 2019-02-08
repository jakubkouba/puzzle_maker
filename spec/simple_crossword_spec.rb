RSpec.describe PuzzleMaker::SimpleCrossword do

  describe 'generate' do
    it 'return self' do
      result = ''
      available_answers = []
      simple_crossword_puzzle = described_class.new(result: result, available_answers: available_answers)
      expect(simple_crossword_puzzle.generate).to eq simple_crossword_puzzle
    end
  end
end