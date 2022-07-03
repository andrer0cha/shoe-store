# frozen_string_literal: true

require 'active_record'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'tmp/shoe_store.db'
  )
  
  Dir['./lib/models/*.rb'].each do |app|
    require app
  end
end