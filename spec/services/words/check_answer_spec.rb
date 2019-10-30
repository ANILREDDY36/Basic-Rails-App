require 'rails_helper'

describe Words::CheckAnswer do
  describe '#call' do
    subject { described_class.new(word, game, answer) }
    
    let(:game) { create(:game) }

    context 'when user provided good answer' do
      let(:word) { create(:word, :with_translations) }
      let(:answer) { word.translations.first.content }

      it { expect(subject.call).to eq(true) }

      it 'increments good answers count' do
        expect { subject.call }.to change { game.reload.good_answer_count }.from(0).to(1)
      end

      it 'does not increments good answers count' do
        expect { subject.call }.to change { game.reload.bad_answer_count }
      end
    end

    context 'when user provided bad answer' do
      let(:word) { create(:word, :with_translations) }
      let(:answer) { 'jfjewnfenw' }

      it { expect(subject.call).to eq(false) }

      it 'increments bad answers count' do
        expect { subject.call }.to change { game.reload.bad_answer_count }.from(0).to(1)
      end

      it 'does not increments bad answers count' do
        expect { subject.call }.to change { game.reload.good_answer_count }
      end
    end
  end  
end
