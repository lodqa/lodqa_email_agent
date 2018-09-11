# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/searches"

    def post_query(question, address_to_send)
      callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail/#{address_to_send}/events"
      post_params = { query: question,
                      callback_url: callback_url }

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
    rescue RestClient::ExceptionWithResponse
      WarningMailer.deliver_email('warning mail', address_to_send)
    rescue Errno::ECONNREFUSED, Net::OpenTimeout, SocketError
      FailureMailer.deliver_email('failure mail', address_to_send)
    end
  end
end
