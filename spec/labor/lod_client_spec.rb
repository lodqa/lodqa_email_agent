# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LodqaClient do
  describe 'post_query' do
    before do
      ENV['HOST_LODQA_EMAIL_AGENT'] = 'lodqa_email_agent:3000'
      ENV['FROM_EMAIL'] = 'lodqa_test@luxiar.com'
      LodqaClient::SERVER_URL = 'http://lodqa_bs:3000/searches'
      @question = 'answers?'
      @address_to_send = 'lodemailagent@gmail.com'
      @option = { 'read_timeout' => 10, 'sparql_limit' => 100, 'answer_limit' => 10, 'cache' => 'no' }
      registered_query = { callback_url: "http://lodqa_email_agent:3000/mail/#{@address_to_send}/events",
                           answer_limit: 10, cache: 'no', query: @question, read_timeout: 10, sparql_limit: 100 }
      @stub_success = stub_request(:post, LodqaClient::SERVER_URL).with(body: registered_query).to_return(status: 200)
    end

    context 'LODQA_BSから成功レスポンスが帰ってきたとき' do
      it 'nilを返すこと' do
        expect(subject.post_query(@question, @address_to_send, @option)).to eq nil
        expect(@stub_success).to have_been_requested
      end
    end

    context '異常レスポンスが帰ってきた時' do
      before { stub_request(:post, LodqaClient::SERVER_URL).to_raise Errno::ECONNREFUSED }
      it 'nilを返すこと' do
        expect(subject.post_query(@question, @address_to_send, {})).to eq nil
      end
    end
  end
end
