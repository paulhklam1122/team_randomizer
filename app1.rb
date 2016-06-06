require "sinatra"
require "sinatra/reloader"
enable :sessions

get "/" do
 erb :index, layout: :app_layout
end

post '/acquire_team' do
 puts params
 session[:input] = params[:names]
 session[:teams] = params[:names].split(",")
 session[:method] = params[:method]
 @check = params[:number]
 
