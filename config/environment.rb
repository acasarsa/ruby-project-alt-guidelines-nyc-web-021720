require 'bundler'
require 'date'
require_relative '../lib/po_controller'
require "tty-prompt"
require "tty-box"
require "colorize"



# in config/environment.rb add this line:
# ActiveRecord::Base.logger = nil



Bundler.require

ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

