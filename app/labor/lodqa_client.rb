# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/searches"

    def post_query(question, address_to_send)
      return WarningMailer.deliver_email('warning mail', address_to_send) if question.blank?

      ini = IniFile.load('./queryOption.ini')
      callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail/#{address_to_send}/events"
      post_params = { query: question,
                      read_timeout: ini[:global]['read_timeout'],
                      sparql_limit: ini[:global]['sparql_limit'],
                      answer_limit: ini[:global]['answer_limit'],
                      cache: ini[:global]['cache'],
                      callback_url: callback_url }
      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
      puts 'POST succcess.'
    rescue Errno::ECONNREFUSED, Net::OpenTimeout, SocketError
      puts 'POST failed.'
      FailureMailer.deliver_email('failure mail', address_to_send)
    end
  end
end
