# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    SERVER_URL = "http://#{ENV['HOST_LODQA_BS']}/searches"
    def post_query(question, address_to_send, query_option)
      return WarningMailer.deliver_email('warning mail', address_to_send) if question.blank?
      callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail/#{address_to_send}/events"
      post_params = { query: question, callback_url: callback_url }
      post_params = post_params_add(post_params, query_option) unless query_option.blank?

      RestClient::Request.execute method: :post, url: SERVER_URL, payload: post_params
      puts 'POST succcess.'
    rescue Errno::ECONNREFUSED, Net::OpenTimeout, SocketError
      puts 'POST failed.'
      FailureMailer.deliver_email('failure mail', address_to_send)
    end

    private

    # query_optionがある場合はpost_paramsに追加する
    def post_params_add(post_params, query_option)
      post_params[:read_timeout] = query_option['read_timeout'] unless query_option['read_timeout'].blank?
      post_params[:sparql_limit] = query_option['sparql_limit'] unless query_option['sparql_limit'].blank?
      post_params[:answer_limit] = query_option['answer_limit'] unless query_option['answer_limit'].blank?
      post_params[:cache] = query_option['cache'] unless query_option['cache'].blank?
      post_params
    end
  end
end
