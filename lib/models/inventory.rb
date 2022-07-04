# frozen_string_literal: true
require './lib/models/application_record'

class Inventory < ApplicationRecord
  belongs_to :store
  belongs_to :shoe_model
end