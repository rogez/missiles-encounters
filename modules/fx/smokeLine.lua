SmokeLine = class.set()

function SmokeLine:init(pX, pY, pSizeMax, pSpeed, pStay, pDelay)
    self.active = true
    self.x = pX
    self.y = pY
    self.delay = pDelay
    self.stay = pStay
    self.sizeMax = pSizeMax
    self.speed = pSpeed
    self.size =0
    self.slowMove = 0
end

function SmokeLine:update()
    if self.size < self.sizeMax then
        self.size = self.size + self.speed
    elseif self.stay > 0 then
        self.stay = self.stay - 1
        self.slowMove = self.slowMove + 1
        if math.fmod(self.slowMove, 50) == 0 then
            self.x = self.x + love.math.random(3)-2
            self.y = self.y + love.math.random(3)-2
        end
    elseif self.stay <=0 then
        self.active = false        
    end
end

function SmokeLine:draw()
    gfx:setColor(50, 50, 50, self.stay+50)
    love.graphics.circle("fill", self.x, self.y, self.size)        
    gfx:setColor(255, 255, 255, 255)    
end
