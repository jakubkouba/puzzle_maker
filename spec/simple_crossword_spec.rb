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

    let(:selected_answers) do
      select_answers
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

        specify 'selected answers contain SelectedAnswer' do
          expect(selected_answers.first).to be_an_instance_of PuzzleMaker::SelectedAnswer
        end

        specify 'SelectedAnswer is initialized with answer "a" and letter of result "a"' do
          expect(PuzzleMaker::SelectedAnswer).to receive(:new).with('a', 'a')
          select_answers
        end
      end

      describe 'list of available answers is [ "bb", "ba" ]' do
        let(:available_answers) { ['bb', 'ba'] }

        specify 'selected answers will contain answer "ba"' do
          expect(selected_answers.map(&:word)).to include 'ba'
        end

        it 'removes selected answer from list of available answers' do
          expect { select_answers }.to change { simple_crossword_puzzle.available_answers }.to ['bb']
        end
      end

      describe 'available answers does not provide solution' do
        let(:available_answers) { ['cc'] }

        it 'raise an error' do
          expect { select_answers }.to raise_error PuzzleMaker::SolutionNotFoundError
        end
      end
    end

    describe 'result is "ab"' do
      let(:result) { 'ab' }

      describe 'list of available answers is ["ac", "cb"]' do
        let(:available_answers) { ['ac', 'cb'] }

        specify 'selected answers contain "ac" and "cb"' do
          expect(selected_answers.map(&:word)).to match_array(['ac', 'cb'])
        end
      end
    end
  end

  describe '#width' do
    subject(:width) { simple_crossword_puzzle.width }

    describe 'when result is "ab"' do
      let(:result) { 'ab' }


      describe 'list of answers is ["a", "b"]' do
        let(:available_answers) { ['a', 'b'] }

        specify 'puzzle width is 1' do
          expect(width).to eq 1
        end
      end

      describe 'list of answer is [ "aa", "cb"]' do
        let(:available_answers) { ['aa', 'cb'] }

        xit { is_expected.to eq 3 }
      end
    end
  end
end

RSpec.describe PuzzleMaker::SelectedAnswer do
  let(:selected_answer) { described_class.new(word, matching_letter) }

  describe '#length' do
    subject(:length) { selected_answer.length }

    let(:word) { 'abc' }
    let(:matching_letter) { '' }

    it { is_expected.to eq 3 }
  end

  describe '#left offset' do
    subject(:left_offset) { selected_answer.left_offset }

    context 'when word is "a" and matching letter is "a"' do
      let(:word) { 'a' }
      let(:matching_letter) { 'a' }

      it { is_expected.to eq 0 }
    end

    context 'when word is "ba" and matching letter is "a"' do
      let(:word) { 'ba' }
      let(:matching_letter) { 'a' }

      it { is_expected.to eq 1 }
    end
  end
  
  describe '#rigth_offset' do
    subject(:right_offset) { selected_answer.right_offset }

    context 'when word is "a" and matching letter is "a"' do
      let(:word) { 'a' }
      let(:matching_letter) { 'a' }

      it { is_expected.to eq 0 }
    end

    context 'when word is "ab" and matching letter is "a"' do
      let(:word) { 'ab' }
      let(:matching_letter) { 'a' }

      it { is_expected.to eq 1 }
    end
  end
end