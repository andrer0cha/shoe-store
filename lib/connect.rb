# frozen_string_literal: true

require 'faye/websocket'
require 'eventmachine'
require 'pry-byebug'
require 'json'

Dir['./lib/services/**/*.rb'].each do |app|
  require app
end

EM.run {
  ws = Faye::WebSocket::Client.new('ws://localhost:8080')

  ws.on :open do |event|
    p [:connected]
  end

  ws.on :message do |event|
    puts [:new_order, event.data]
    Services::Inventories::Receive.new(JSON.parse(event.data)).call
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}