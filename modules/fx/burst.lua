Burst = class.set()

function Burst:init(pX, pY, pSizeMax, pSpeed, pDelay)    
    self.active = true
    self.x = pX
    self.y = pY

    -- Variables spécifiques aux bursts
    self.sizeMax = pSizeMax
    self.speed = pSpeed
    self.delay = pDelay        
    self.size =0        
end

function Burst:update()
    self.size = self.size + self.speed
    if self.size >= self.sizeMax and self.speed > 0 then
        self.speed = 0 - self.speed    
    elseif self.size <= 0 and self.speed < 0 then
        self.size = self.size + self.speed
        self.active = false        
    end    
end

function Burst:draw()
    local color = love.math.random(101,200)
    color = color / 255
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.size+2)
    love.graphics.setColor(color+0.4, color-0.4, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.size) 
    love.graphics.setColor(color+0.1, color-0.1, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.size-2)    
    love.graphics.setColor(color+0.04, color-0.4, 0, 1)
    love.graphics.circle("fill", self.x, self.y, self.size-4)    
    love.graphics.setColor(1,1,1,1)
end
