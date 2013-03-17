require 'json'
require File.dirname(__FILE__) + '/lib/native2ascii'

get '/' do
  erb :index
end

post '/api/convert' do
  src = params[:text]
  converted = nil

  if params[:mode] == 'native2ascii'
    converted = src.to_ascii
  else
    converted = src.to_native
  end
  converted = converted.escapeHTML if params[:escape] == 'true'

  content_type :json, :charset => 'utf-8'
  { text: converted }.to_json
end

