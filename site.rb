require 'rubygems'
require 'sinatra'
require 'i18n'
require 'i18n/backend/fallbacks'

configure do
	I18n.available_locales = [:es, :en, :ca, :de]
	I18n.default_locale = :en
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.load_path = Dir['./config/locales/*.yml']
  I18n.fallbacks.map(:ca => :es)
  I18n.backend.load_translations
end

before '/' do
  redirect '/en/'
end

before '/:locale/*' do
  I18n.locale       =       params[:locale]
  request.path_info = '/' + params[:splat ][0]
end


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
  params[:card] = 'card01' unless valid_template?(params[:card])  
  erb :final_card, :locals => { :party_data => params }, :layout => false
end

not_found do
  status 404
  erb :oops, :layout => false
end

def valid_template? template
  valid_templates = ['card01', 'card02', 'card03']
  valid_templates.include?(template)
end
