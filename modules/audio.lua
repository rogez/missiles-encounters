Audio = class.set()

function Audio:init()
    self.shoot = love.audio.newSource("audio/shoot.wav", "static")
    self.boom1 = love.audio.newSource("audio/boom1.wav", "static")
    self.cityboom = love.audio.newSource("audio/cityboom.wav", "static")
    self.gameover = love.audio.newSource("audio/gameover.wav", "static")
    self.baseboom = love.audio.newSource("audio/baseboom.wav", "static")
    self.outofammo = love.audio.newSource("audio/outofammo.wav", "static")        
    self.redball = love.audio.newSource("audio/redball.wav", "static")        
    self.levelup = love.audio.newSource("audio/levelup.wav", "static")     
    self.ufo = love.audio.newSource("audio/ufo.wav", "static")        
    self.beam = love.audio.newSource("audio/beam.wav", "static")
end

return class.new(Audio)
