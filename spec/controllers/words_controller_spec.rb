# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe 'GET index' do
    before { get :index }

    context 'when some words' do
      let!(:word) { create(:word) }

      it 'assigns @words' do
        expect(assigns(:words)).to eq([word])
      end
      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when no words' do
      it 'assigns @words' do
        expect(assigns(:words)).to eq([])
      end
      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET new' do
    context 'when user has signed in' do
      let(:user) { create(:user) }
      before do
        sign_in(user)
        get :new
      end

      it 'assigns @word' do
        expect(assigns(:word)).to be_a_new(Word)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user has not signed in' do
      before do
        get :new
      end

      it 'does not assigns @word' do
        expect(assigns(:word)).to eq(nil)
      end

      it 'does not renders the new template' do
        expect(response).not_to render_template(:new)
      end

      it do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when user has signed in' do
      let(:user) { create(:user) }
      before { sign_in(user) }

      context 'valid params' do
        let!(:language) { create(:language) }
        let(:params) do
          { word: { content: 'cat', language_id: language.id } }
        end

        it 'creates the new word' do
          expect { subject }.to change(Word, :count).from(0).to(1)
        end

        it do
          subject
          expect(response).to have_http_status(302)
        end
      end

      context 'invalid params' do
        let(:params) do
          { word: { content: '' } }
        end
        it 'does not creates the new word' do
          expect { subject }.not_to change(Word, :count)
        end
        it do
          subject
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'when user has not signed in' do
      context 'valid params' do
        let!(:language) { create(:language) }
        let(:params) do
          { word: { content: 'cat', language_id: language.id } }
        end
        it 'does not create the new word' do
          expect { subject }.not_to change(Word, :count)
        end
        it do
          subject
          expect(response).to have_http_status(302)
        end
      end

      context 'invalid params' do
        let(:params) do
          { word: { content: '' } }
        end
        it 'does not creates the new word' do
          expect { subject }.not_to change(Word, :count)
        end
        it do
          subject
          expect(response).to have_http_status(302)
        end
      end
    end
  end

  describe 'GET show' do
    before { get :show, params: params }
    let(:params) do
      { id: word.id }
    end
    let!(:word) { create(:word) }
    it 'assigns @word' do
      expect(assigns(:word)).to eq(word)
    end
    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET edit' do
    subject { get :edit, params: params }

    let(:params) do
      { id: word.id }
    end
    let!(:word) { create(:word, user: user) }
    let(:user) { create(:user) }
    context 'when user has signed in' do
      before do
        sign_in(user)
        subject
      end  
      it 'assigns @word' do
        expect(assigns(:word)).to eq(word)
      end
      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end

      it do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'when user has not signed in' do
      
      it 'does not assigns @word' do
        expect(assigns(:word)).to eq(nil)
      end
      it do
        subject
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PUT update' do
    subject { put :update, params: params }
    let!(:word) { create(:word, user: user, content: 'bat', language: language_1) }
    let!(:language_1) { create(:language, name: 'English') }
    let!(:language_2) { create(:language, name: 'Polish') }
    let!(:user) { create(:user) }
    context 'when user has signed in' do
      before { sign_in(user) }
      context 'valid params' do
        let(:params) do
          { id: word.id, word: { content: 'dog', language_id: language_2.id } }
        end
        it 'updates word' do
          expect { subject }
            .to change { word.reload.content }
            .from('bat')
            .to('dog')
            .and change { word.reload.language }
            .from(language_1)
            .to(language_2)
        end

        it do
          expect(response).to have_http_status(200)
        end
      end

      context 'invalid params' do
        let(:params) do
          { id: word.id, word: { content: '' } }
        end
        it 'does not update word' do
          expect { subject }.not_to change { word.reload.content }
        end
      end
    end

    context 'when user has not signed in' do
      
      context 'valid params' do
        let(:params) do
          { id: word.id, word: { content: 'dog', language_id: language_2.id } }
        end
        it 'updates word' do
          expect { subject }.not_to change { word.reload.content }
        end
      end

      context 'invalid params' do
        let(:params) do
          { id: word.id, word: { content: '' } }
        end
        it 'does not update word' do
          expect { subject }.not_to change { word.reload.content }
        end
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params: params }

    context 'when user has signed in' do
      let(:user) { create(:user) }
      before { sign_in(user) }
      let!(:word) { create(:word, user: user) }
      context 'valid params' do
        let(:params) do
          { id: word.id }
        end

        it 'deletes word' do
          expect { subject }.to change(Word, :count).from(1).to(0)
        end
        it do
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'when user has not signed in' do
      
      let!(:word) { create(:word) }
      context 'valid params' do
        let(:params) do
          { id: word.id }
        end

        it 'does not deletes word' do
          expect { subject }.not_to change(Word, :count)
        end
        it do
          expect(response).to have_http_status(200)
        end
      end
    end 
  end
end
