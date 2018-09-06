# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/searches"

    def post_query(question, address_to_send)
      start_callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail/#{address_to_send}/start"
      finish_callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail/#{address_to_send}/finish"
      post_params = { query: question,
                      start_search_callback_url: start_callback_url,
                      finish_search_callback_url: finish_callback_url }

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
    end
  end
end
