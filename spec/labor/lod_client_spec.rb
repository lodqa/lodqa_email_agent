# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LodqaClient do
  describe '#post_query' do
    before do
      ENV['HOST_LODQA_EMAIL_AGENT'] = 'lodqa_email_agent:3000'
      ENV['FROM_EMAIL'] = 'lodqa_test@luxiar.com'
      LodqaClient::SERVER_URL = 'http://lodqa_bs:3000/searches'
      @question = 'answers?'
      @address_to_send = 'lodemailagent@gmail.com'
      @option = { 'read_timeout' => 10, 'sparql_limit' => 100, 'answer_limit' => 10, 'cache' => 'no' }
      @stub = stub_request(:post, LodqaClient::SERVER_URL)
    end

    it '成功レスポンスが帰ってくること' do
      registered_query = { answer_limit: 10, cache: 'no',
                           callback_url: "http://lodqa_email_agent:3000/mail/#{@address_to_send}/events",
                           query: @question, read_timeout: 10, sparql_limit: 100 }
      stub = @stub.with(body: registered_query).to_return(status: 200)
      expect(subject.post_query(@question, @address_to_send, @option)).to eq nil
      expect(stub).to have_been_requested
    end

    it '異常レスポンスが帰ってくること' do
      @option = {}
      @stub.to_raise Errno::ECONNREFUSED
      expect(subject.post_query(@question, @address_to_send, @option)).to eq nil
    end
  end
end
