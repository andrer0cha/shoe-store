# frozen_string_literal: true
require './lib/models/application_record'

class Store < ApplicationRecord
  has_many :inventories
  has_one  :inventory_config
end