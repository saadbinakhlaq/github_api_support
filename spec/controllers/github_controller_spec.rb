require 'rails_helper'

RSpec.describe GithubController, type: :controller do
  describe 'GET #search' do
    context 'when no query param is given' do
      subject { get :search }
      it 'renders the search template' do
        subject
        expect(response).to render_template('search')
      end
    end

    context 'when query params are given' do
      let(:query) { 'data' }
      let(:page)  { '3' }
      let(:per_page)  { '10' }

      subject do
        get :search, params: {
          query: query,
          page: page,
          per_page: per_page
        }
      end

      it 'sends correct arguments to Github.search' do
        expect(Github).to receive(:search).
          with(query, page: page, per_page: per_page).
          and_return(Github::Response.new([], 0))
        subject
      end
    end
  end
end