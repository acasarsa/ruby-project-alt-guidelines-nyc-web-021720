require 'bundler'
require 'date'
require_relative '../lib/po_controller'
require "tty-prompt"




Bundler.require

# ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
