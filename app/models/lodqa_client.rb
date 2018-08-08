# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/queries"
    CALLBACK_URL = "http://#{ENV['HOST']}/queries/310d4eab-d454-4087-954e-a4b1638c5af2/progress"

    def post_query(question)
      post_params = { query: question,
                      start_search_callback_url: CALLBACK_URL,
                      finish_search_callback_url: CALLBACK_URL }

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
    end
  end
end
