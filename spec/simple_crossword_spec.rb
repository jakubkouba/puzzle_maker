RSpec.describe PuzzleMaker::SimpleCrossword do
  let(:result) { '' }
  let(:available_answers) { [] }
  let(:simple_crossword_puzzle) { described_class.new(result: result, available_answers: available_answers) }

  describe 'generate' do
    subject(:generate) { simple_crossword_puzzle.generate }

    it 'return self' do
      expect(generate).to eq simple_crossword_puzzle
    end
  end

  describe '#selected_answers' do
    subject(:selected_answers) { simple_crossword_puzzle.selected_answers }

    describe 'when result is empty and list of available answers is empty' do

      it 'returns empty list' do
        expect(selected_answers).to eq []
      end
    end
  end
end