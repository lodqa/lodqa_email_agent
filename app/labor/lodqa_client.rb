# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/queries"

    def post_query(question, address_to_send)
      callback_url = "http://#{ENV['HOST']}/mails/#{address_to_send}/progress"
      post_params = { query: question,
                      start_search_callback_url: callback_url,
                      finish_search_callback_url: callback_url }

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
    end
  end
end
