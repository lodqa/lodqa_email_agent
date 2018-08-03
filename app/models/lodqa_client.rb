class LodqaClient

  def post_query question
    server_url = 'http://localhost/queries'
    callback_url = 'https://webhook.site/7857288e-e2a6-4030-bce4-055b312752c9'
    post_params = { query: question,
                    start_search_callback_url: callback_url,
                    finish_search_callback_url: callback_url }

    response = RestClient::Request.execute( method: :post,
                                            url: server_url,
                                            payload: post_params )
    return response
  end
end
