# frozen_string_literal: true
require 'pry-byebug'
require 'awesome_print'
Dir['./lib/models/*.rb'].each do |app|
  require app
end

module Services
  module Inventories
    class Receive

      def initialize(data)
        ActiveRecord::Base.establish_connection(
          adapter: 'sqlite3',
          database: 'tmp/shoe_store.db'
        )

        @store = Store.find_by(name: data["store"])
        @shoe_model = ShoeModel.find_by(name: data["model"])
        @qnty = data["inventory"]
      end

      def call
        update_inventory_registry
        check_inventory_health
      end

      private

      def update_inventory_registry
        new_qty = inventory_registry.qnty - @qnty
        inventory_registry.update(qnty: new_qty)
      end

      def inventory_registry
        Inventory.find_by(store_id: @store.id, shoe_model_id: @shoe_model.id)
      end

      def check_inventory_health
        return suggest_exchange if low_data && stores_with_inventory.any?
        
        suggest_buy if low_data
      end

      def suggest_buy
        puts "BUY MORE ENTRIES FOR: #{buy_data}".red
      end

      def low_data
        inventory_registry.qnty <= store_inventory_config.min_safe_qnty
      end

      def buy_data
        "\n
          Store: #{@store.name} 
          Model: #{@shoe_model.name}
          Suggested Qnty: #{store_inventory_config.min_safe_qnty - inventory_registry.qnty}
        "
      end

      def store_inventory_config
        @store_inventory_config ||= InventoryConfig.find_by(store_id: @store.id, shoe_model_id: @shoe_model.id)
      end

      def suggest_exchange
        puts "EXCHANGE ENTRIES FOR: #{exchange_data}".yellow
      end

      def exchange_data
        "\n
          Destination Store: #{@store.name} 
          Model: #{@shoe_model.name}
          Suggested Qnty: #{store_inventory_config.min_safe_qnty - inventory_registry.qnty}
          Available Origin Stores: #{stores_with_inventory}
        "
      end

      def stores_with_inventory
        InventoryConfig
          .joins(store: :inventories)
            .where(
              shoe_model: @shoe_model,
              inventories: {
                shoe_model: @shoe_model
              }
            )
            .where('inventories.qnty > inventory_configs.max_safe_qnty')
            .pluck(:name).reject{ |name| name == @store.name }
      end
    end
  end
end