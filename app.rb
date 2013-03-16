require 'pp'
require 'json'
require File.dirname(__FILE__) + '/lib/native2ascii'

get '/' do
  erb :index
end

post '/api/convert' do
  src = params[:text]
  converted = nil
  if params[:mode] == 'native2ascii'
    converted = Native2Ascii.to_ascii(src)
  else
    converted = Native2Ascii.to_native(src)
  end
  content_type :json, :charset => 'utf-8'
  { text: converted }.to_json
end

