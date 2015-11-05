require 'data_mapper'
require 'dm-postgres-adapter'

require './app/models/tag'
require './app/models/link'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
