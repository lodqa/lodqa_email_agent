# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LodqaClient do
  describe 'post_query' do
    let(:question) { 'answers?' }
    let(:mail_subject) { 'please' }
    let(:address_to_send) { 'lodemailagent@gmail.com' }
    let(:server_url) { 'http://lodqa_bs:3000/searches' }
    before(:all) do
      ENV['HOST_LODQA_EMAIL_AGENT'] = 'lodqa_email_agent:3000'
      ENV['FROM_EMAIL'] = 'lodqa_test@luxiar.com'
      ENV['HOST_LODQA_BS'] = 'lodqa_bs:3000'
    end

    context 'LODQA_BSから成功レスポンスが帰ってきたとき' do
      let(:option) { { 'read_timeout' => 10, 'sparql_limit' => 100, 'answer_limit' => 10, 'cache' => 'no', 'target' => 'bio2rdf-mashup' } }
      before do
        registered_query = { callback_url: "http://lodqa_email_agent:3000/mail_address/#{address_to_send}/mail_subject/#{mail_subject}/events",
                             answer_limit: 10, cache: 'no', query: question, read_timeout: 10, sparql_limit: 100, target: 'bio2rdf-mashup' }
        @stub_success = stub_request(:post, server_url).with(body: registered_query).to_return(status: 200)
      end
      it 'trueを返すこと' do
        expect(subject.post_query(question, address_to_send, mail_subject, option)).to eq true
      end
      it 'LODQA_BSを呼び出すこと' do
        subject.post_query(question, address_to_send, mail_subject, option)
        expect(@stub_success).to have_been_requested
      end
    end

    context '異常レスポンスが帰ってきた時' do
      before { stub_request(:post, server_url).to_raise Errno::ECONNREFUSED }
      it 'falseを返すこと' do
        expect(subject.post_query(question, address_to_send, mail_subject, {})).to eq false
      end
      it 'エラーメールが送信されることを確認' do
        allow(FailureMailer).to receive(:deliver_email)
      end
    end
  end
end
