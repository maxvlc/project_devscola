require 'rubygems'
require 'sinatra'

get '/' do
	erb :form
end

post '/form' do
	erb :selection, :locals => { :party_data => params }
end

post '/cards' do
	erb :generator, :locals => { :party_data => params }
end

get '/:card/:whoinvites/:guestname/:eventdate/:event/:eventplace' do
  erb :final_card, :locals => { :party_data => params }
end

not_found do
  status 404
  erb :oops, :layout => false
end