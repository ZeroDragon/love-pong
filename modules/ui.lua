UI = {}

function UI:load()
  self.width = love.graphics.getWidth()
  self.height = 5
  self.x = 0
  self.y = love.graphics.getHeight() / 2 - self.height / 2
  self.sections = 40
  self.sectionWidth = self.width / self.sections
  self.span = 20

  self.soundTypes = {
    Player = envelope(440.0),
    AI = envelope(240.0),
    Score = envelope(550.0)
  }
end

function UI:update(dt)
end

function UI:draw()
  for sect = 0, self.sections - 1, 1 do
    local x = sect * self.sectionWidth + self.span / 2
    local width = self.sectionWidth - self.span / 2
    love.graphics.rectangle("fill", x, self.y, width, self.height)
  end
  local font = love.graphics.newFont(200)
  local playerWidth = font:getWidth(Player.score)
  local AIWidth = font:getWidth(AI.score)
  local color = { 255,255,255,0.1 }

  love.graphics.print(
    { color, Player.score },
    font,
    love.graphics.getWidth() / 2 - 60,
    love.graphics.getHeight() - 400
  )
  love.graphics.print(
    { color, AI.score },
    font,
    love.graphics.getWidth() / 2 - 60,
    love.graphics.getHeight() / 2 - 400
  )
end

function envelope(Hz)
  local rate      = 44100 -- samples per second
  local length    = 1/32  -- 0.03125 seconds
  local tone      = Hz
  local p         = math.floor(rate/tone) -- 100 (wave length in samples)
  local soundData = love.sound.newSoundData(math.floor(length*rate), rate, 16, 1)
  for i=0, soundData:getSampleCount() - 1 do
    soundData:setSample(i, i%p<p/2 and 1 or -1)
  end
  return love.audio.newSource(soundData)
end

function UI:beep(type)
  self.soundTypes[type]:play()
end
