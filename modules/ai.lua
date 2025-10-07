AI = {}


function AI:load()
  self.width = 100
  self.height = 20
  self.x = love.graphics.getWidth() / 2 - self.width / 2
  self.y = 30
  self.xVel = 0
  self.speed = 500

  self.timer = 0
  self.rate = 0.1
  self.score = 0
end


function AI:update(dt)
  self:move(dt)
  self.timer = self.timer + dt
  if self.timer > self.rate then
    self.timer = 0
    self:acquireTarget()
  end
end


function AI:move(dt)
  self.x = self.x + self.xVel * dt
end


function AI:acquireTarget()
  self.xVel = 0
  if Ball.y > love.graphics.getHeight() / 2 then return end
  if Ball.x + Ball.width < self.x then
    self.xVel = -self.speed
  elseif Ball.x > self.x + self.width then
    self.xVel = self.speed
  end
end


function AI:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
