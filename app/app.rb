ENV['RACK_ENV'] ||= 'development'

require './app/models/link'
require './app/models/user'
require 'sinatra/base'
require './data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions

  set :session_secret, 'super secret'

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'/links/new'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    tag_ary = params[:tag].split(' ')
    tag_ary.each do |item|
      tag = Tag.create(name: item)
      link.tags << tag
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  post '/tags' do
    name = params[:name]
    redirect "/tags/#{name}"
  end

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    @username = params[:username]
    @email = params[:email]
    @password = params[:password]
    @password_conf = params[:password_conf]
    user = User.new(username: @username, email: @email, password: @password,password_confirmation: @password_conf)
    if user.save
    session[:user_id] = user.id
    else
      session[:user_id] = "Password don't match"
    end
    puts "********"
    puts session[:user_id]
    redirect '/links'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
