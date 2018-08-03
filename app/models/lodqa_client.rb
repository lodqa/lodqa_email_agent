# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = 'http://localhost/queries'
    CALLBACK_URL = 'https://webhook.site/7857288e-e2a6-4030-bce4-055b312752c9'

    def post_query(question)
      post_params = { query: question,
                      start_search_callback_url: CALLBACK_URL,
                      finish_search_callback_url: CALLBACK_URL }

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
    end
  end
end
