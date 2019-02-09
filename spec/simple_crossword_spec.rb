RSpec.describe PuzzleMaker::SimpleCrossword do
  let(:result) { '' }
  let(:available_answers) { [] }
  let(:simple_crossword_puzzle) { described_class.new(result: result, available_answers: available_answers) }

  describe 'generate' do
    subject(:generate) { simple_crossword_puzzle.generate }

    it 'return self' do
      expect(generate).to eq simple_crossword_puzzle
    end

    it 'populates selected answers' do
      generate
      expect(simple_crossword_puzzle.selected_answers).not_to be_nil
    end
  end

  describe '#select_answers' do
    subject(:select_answers) { simple_crossword_puzzle.select_answers }

    describe 'when result is empty and list of available answers is empty' do

      fit 'returns empty list' do
        expect(select_answers).to eq []

      end
    end

    describe 'when result is "a" and list of available answers contains "a"' do
      let(:available_answers) { ['a'] }

      it 'returns list with one SelectedAnswer object' do
        expect(select_answers.first).to be_an_instance_of PuzzleMaker::SelectedAnswer
      end
    end
  end
end