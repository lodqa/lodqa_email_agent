# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/queries"

    def post_query(question, send_to_mail)
      callback_url = "http://#{ENV['HOST']}/queries/#{send_to_mail}/progress"
      post_params = { query: question,
                      start_search_callback_url: callback_url,
                      finish_search_callback_url: callback_url }

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
    end
  end
end
