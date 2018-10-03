# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LodqaClient do
  describe '#post_query' do
    ENV['HOST_LODQA_EMAIL_AGENT'] = 'lodqa_email_agent:3000'
    ENV['FROM_EMAIL'] = 'lodqa_test@luxiar.com'
    LodqaClient::SERVER_URL = 'http://lodqa_bs:3000/searches'
    question = 'answers?'
    address_to_send = 'lodemailagent@gmail.com'
    it '成功の場合' do
      option = { 'read_timeout' => 10, 'sparql_limit' => 100, 'answer_limit' => 10, 'cache' => 'no' }
      registered_query = { answer_limit: 10, cache: 'no',
                           callback_url: "http://lodqa_email_agent:3000/mail/#{address_to_send}/events",
                           query: question, read_timeout: 10, sparql_limit: 100 }
      stub = stub_request(:post, LodqaClient::SERVER_URL)
             .with(body: registered_query)
             .to_return(status: 200)
      expect(subject.post_query(question, address_to_send, option)).to eq nil
      expect(stub).to have_been_requested
    end
    it '異常の場合' do
      option = {}
      stub_request(:post, LodqaClient::SERVER_URL)
        .to_raise Errno::ECONNREFUSED
      expect(subject.post_query(question, address_to_send, option)).to eq nil
    end
  end
end
