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
    let(:selected_answers) do
      simple_crossword_puzzle.select_answers
      simple_crossword_puzzle.selected_answers
    end

    describe 'when result is empty and list of available answers is empty' do

      it 'returns empty list' do
        expect(selected_answers).to eq []

      end
    end

    describe 'when result is "a"' do
      let(:result) { 'a' }

      describe 'list of available answers is ["a"]' do
        let(:available_answers) { ['a'] }

        specify 'selected answers contain just one item' do
          expect(selected_answers.count).to eq 1
        end

        specify 'selected answers contain just one item which is instance of SelectedAnswer' do
          expect(selected_answers.first).to be_an_instance_of PuzzleMaker::SelectedAnswer
        end

        specify 'selected answers contain correct word' do
          expect(selected_answers.first.word).to eq 'a'
        end

        specify 'selected answers contain correct word with its length' do
          expect(selected_answers.first.length).to eq 1
        end

        specify 'selected answers contain correct word with its matching position' do
          # matching position is index of letter which fits to the result of puzzle
          expect(selected_answers.first.matching_position).to eq 1
        end
      end

      describe 'list of available answers is ["ba"]' do
        let(:available_answers) { ['ba'] }

        specify 'matching position is of selected answer is 2' do
          expect(selected_answers.first.matching_position).to eq 2
        end

      end
    end
  end
end