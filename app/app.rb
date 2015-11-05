ENV['RACK_ENV'] ||= 'development'

require './app/models/link'
require 'sinatra/base'
require './data_mapper_setup'

class BookmarkManager < Sinatra::Base
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
