# frozen_string_literal: true

# LODQA BSにHTTPリクエストを送る
module LodqaClient
  class << self
    def post_query(question, address_to_send, subject, option)
      return WarningMailer.deliver_email('warning mail', address_to_send) if question.blank?
      mail_subject = URI.encode_www_form_component(subject)
      callback_url = "http://#{ENV['HOST_LODQA_EMAIL_AGENT']}/mail_address/#{address_to_send}/mail_subject/#{mail_subject}/events"
      post_params = { query: question, callback_url: callback_url }
      post_params = populate_options(post_params, option) if option.present?

      server_url = "http://#{ENV['HOST_LODQA_BS']}/searches"
      RestClient::Request.execute method: :post, url: server_url, payload: post_params
      puts 'POST succcess.'
      true
    rescue Errno::ECONNREFUSED, Net::OpenTimeout, SocketError
      FailureMailer.deliver_email('failure mail', address_to_send)
      puts 'POST failed.'
      false
    end

    private

    # optionがある場合はpost_paramsに追加する
    def populate_options(post_params, option)
      post_params[:read_timeout] = option['read_timeout'] if option['read_timeout'].present?
      post_params[:sparql_limit] = option['sparql_limit'] if option['sparql_limit'].present?
      post_params[:answer_limit] = option['answer_limit'] if option['answer_limit'].present?
      post_params[:cache] = option['cache'] if option['cache'].present?
      post_params[:target] = option['target'] if option['target'].present?
      post_params
    end
  end
end
