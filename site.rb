require 'rubygems'
require 'sinatra'

get '/' do
	erb :form
end

post '/form' do
	erb :selection, :locals => {:user_data => params}
end