Player = {}

function Player:load()
  self.width = 100
  self.height = 20
  self.x = love.graphics.getWidth() / 2 - self.width / 2
  self.y = love.graphics.getHeight() - 50
  self.speed = 500
  self.score = 0
end

function Player:update(dt)
  self:move(dt)
  self:checkBoundaries()
end

function Player:move(dt)
  if love.keyboard.isDown("a") then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown("d") then
    self.x = self.x + self.speed * dt
  end
end

function Player:checkBoundaries()
  if self.x < 0 then
    self.x = 0
  elseif self.x + self.width > love.graphics.getWidth() then
    self.x = love.graphics.getWidth() - self.width
  end
end

function Player:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
