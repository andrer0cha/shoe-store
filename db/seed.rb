# frozen_string_literal: true
require './lib/models/application_record'

module Db
  class Seed
    STORE_STORES = ['ALDO Centre Eaton', 'ALDO Destiny USA Mall', 'ALDO Pheasant Lane Mall', 'ALDO Holyoke Mall', 'ALDO Maine Mall', 'ALDO Crossgates Mall', 'ALDO Burlington Mall', 'ALDO Solomon Pond Mall', 'ALDO Auburn Mall', 'ALDO Waterloo Premium Outlets']
    SHOES_MODELS = ['ADERI', 'MIRIRA', 'CAELAN', 'BUTAUD', 'SCHOOLER', 'SODANO', 'MCTYRE', 'CADAUDIA', 'RASIEN', 'WUMA', 'GRELIDIEN', 'CADEVEN', 'SEVIDE', 'ELOILLAN', 'BEODA', 'VENDOGNUS', 'ABOEN', 'ALALIWEN', 'GREG', 'BOZZA' ]
    INVENTORY_RANDOMNESS = Array(200..500)
    MIN_SAFE_QNTY_RANDOMNESS = Array(50..299)
    MAX_SAFE_QNTY_RANDOMNESS = Array(300..400)

    Store.destroy_all
    ShoeModel.destroy_all
    Inventory.destroy_all
    InventoryConfig.destroy_all
    
    STORE_STORES.each do |name|
      Store.create(name: name)
    end
    
    SHOES_MODELS.each do |name|
      ShoeModel.create(name: name)
    end
    
    Store.all.each do |store|
      ShoeModel.all.each do |shoe|
        Inventory.create(store_id: store.id, shoe_model_id: shoe.id, qnty: INVENTORY_RANDOMNESS.sample)
        InventoryConfig.create(store_id: store.id, shoe_model_id: shoe.id, min_safe_qnty: MIN_SAFE_QNTY_RANDOMNESS.sample, max_safe_qnty: MAX_SAFE_QNTY_RANDOMNESS.sample)
      end
    end
  end
end
