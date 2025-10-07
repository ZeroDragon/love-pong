require 'modules/player'
require 'modules/ball'
require 'modules/ai'
require 'modules/ui'

function love.load()
  UI:load()
  Player:load()
  Ball:load()
  AI:load()
end

function love.update(dt)
  UI:update(dt)
  Player:update(dt)
  Ball:update(dt)
  AI:update(dt)
end

function love.draw()
  UI:draw()
  Player:draw()
  Ball:draw()
  AI:draw()
end

function checkCollision(a, b)
  return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end
