Missile = class.sub(Mob)

function Missile:init(pDelay, pX, pY)
    Mob.init(self, pDelay, pX, pY)

    self.image = images.missile    
    self.colliderX = self.image:getWidth()/2 * self.scale
    self.colliderY = self.image:getHeight()/2 * self.scale
end

function Missile:update()
    Mob.update(self)
    -- fx:add(class.new(SmokeLine, self.x, self.y, 1, 0.03, 370, 5))    
end

function Missile:draw()
    love.graphics.setColor(0.3, 0.3, 0.3, 0.2)
    love.graphics.line(self.startX, self.startY, self.x, self.y) 
    love.graphics.line(self.startX+1, self.startY, self.x, self.y) 
    love.graphics.line(self.startX+2, self.startY, self.x, self.y) 
    love.graphics.line(self.startX-1, self.startY, self.x, self.y) 
    love.graphics.line(self.startX-2, self.startY, self.x, self.y) 
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y, self.direction, self.scale, self.scale, self.image:getWidth()/2, self.image:getHeight()/2)  
end
