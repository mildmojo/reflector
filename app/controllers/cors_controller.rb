class CorsController < ApplicationController
  # Handle OPTIONS preflight request for cross-domain requests.
  # http://www.tsheffler.com/blog/?p=428
  def options_request
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1000'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
    render text: ''
  end
end
