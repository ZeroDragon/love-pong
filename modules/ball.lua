Ball = {}

function Ball:load()
  self.width = 20
  self.height = 20
  self:reset(1)
end

function Ball:reset(direction)
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.speed = 200
  self.xVel = 0
  self.yVel = self.speed * direction
end

function Ball:update(dt)
  self:move(dt)
  self:collide()
end

function Ball:move(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:collide()
  local actor = checkCollision(self, Player) and "Player" or (checkCollision(self, AI) and "AI" or false)
  if actor then
    local Actor = (actor == "Player") and Player or AI
    UI:beep(actor)
    self.speed = self.speed + 50 -- incrementa velocidad en cada golpe
    self.yVel = (actor == "Player") and -self.speed or self.speed
    local middleBall = self.x + self.width / 2
    local middleActor = Actor.x + Actor.width / 2
    local collisionPosition = middleBall - middleActor
    self.xVel = collisionPosition * 5
  end

  if self.x < 0 then
    self.x = 0
    self.xVel = -self.xVel
  elseif self.x + self.width > love.graphics.getWidth() then
    self.x = love.graphics.getWidth() - self.width
    self.xVel = -self.xVel
  end

  if self.y < 0 then
    self:reset(-1)
    UI:beep('Score')
    Player.score = Player.score + 1
  end
  if self.y + self.height > love.graphics.getHeight() then
    UI:beep('Score')
    self:reset(1)
    AI.score = AI.score + 1
  end
end
