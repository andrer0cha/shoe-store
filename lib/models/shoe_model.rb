# frozen_string_literal: true
require './lib/models/application_record'

class ShoeModel < ApplicationRecord
  has_one :inventory_config
  has_many :inventories
end