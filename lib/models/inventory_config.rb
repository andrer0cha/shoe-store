# frozen_string_literal: true
require './lib/models/application_record'

class InventoryConfig < ApplicationRecord
  belongs_to :store
  belongs_to :shoe_model
end