# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LodqaClient do
  describe 'post_query' do
    let(:question) { 'answers?' }
    let(:address_to_send) { 'lodemailagent@gmail.com' }
    before(:all) do
      ENV['HOST_LODQA_EMAIL_AGENT'] = 'lodqa_email_agent:3000'
      ENV['FROM_EMAIL'] = 'lodqa_test@luxiar.com'
      LodqaClient::SERVER_URL = 'http://lodqa_bs:3000/searches'
    end

    context 'LODQA_BSから成功レスポンスが帰ってきたとき' do
      let(:option) { { 'read_timeout' => 10, 'sparql_limit' => 100, 'answer_limit' => 10, 'cache' => 'no', 'target' => 'bio2rdf-mashup' } }
      before do
        registered_query = { callback_url: "http://lodqa_email_agent:3000/mail/#{address_to_send}/events",
                             answer_limit: 10, cache: 'no', query: question, read_timeout: 10, sparql_limit: 100, target: 'bio2rdf-mashup' }
        @stub_success = stub_request(:post, LodqaClient::SERVER_URL).with(body: registered_query).to_return(status: 200)
      end
      it 'nilを返すこと' do
        expect(subject.post_query(question, address_to_send, option)).to eq true
      end
      it 'LODQA_BSを呼び出すこと' do
        subject.post_query(question, address_to_send, option)
        expect(@stub_success).to have_been_requested
      end
    end

    context '異常レスポンスが帰ってきた時' do
      before { stub_request(:post, LodqaClient::SERVER_URL).to_raise Errno::ECONNREFUSED }
      it 'nilを返すこと' do
        expect(subject.post_query(question, address_to_send, {})).to eq false
      end
      it 'エラーメールが送信されることを確認' do
        allow(FailureMailer).to receive(:deliver_email)
      end
    end
  end
end
