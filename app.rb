require 'json'
require File.dirname(__FILE__) + '/lib/native2ascii'

get '/' do
  erb :index
end

post '/api/convert' do
  src = params[:text]
  converted = nil
  begin
    if params[:mode] == 'native2ascii'
      converted = Native2Ascii.to_ascii(src)
    else
      converted = Native2Ascii.to_native(src)
    end
    converted = converted.escapeHTML if params[:escape]
  rescue => e
    puts e.message
  end
  content_type :json, :charset => 'utf-8'
  { text: converted }.to_json
end

