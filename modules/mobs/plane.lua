Plane = class.sub(Mob)

function Plane:init(pDelay)        
    Mob.init(self, pDelay, -100, love.math.random(150) + 50)

    self.speed = 1.7 + self.level/10
    if self.speed >= 5 then
        self.speed = 5
    end

    self.score = 5
    self.targetX = config.gameWidth + 100
    self.targetY = love.math.random(150) + 50

    self.scale = 2  
    self.image = images.plane
    self.colliderX = self.image:getWidth()/2 * self.scale
    self.colliderY = self.image:getHeight()/2 * self.scale

    self.stage2 = false    
    self.stage2trigX = love.math.random(150)+70
    self.stage2trigBomb = 0
    self.stage2posX = 0
end


function Plane:update()
    Mob.update(self)

    if (self.x >= self.stage2trigX) and not self.stage2 then            
        self.stage2 = true          
        self.stage2posX = self.x
    end        

    if self.stage2 and ((self.x - self.stage2posX) > self.stage2trigBomb) and (self.x <= 730) then                                   
        mobs:add(class.new(Bomb, self.x, self.y+30, 0))
        self.stage2trigBomb = 20 + love.math.random(10)
        self.stage2posX = self.x         
    end

    if self.x > config.gameWidth + 50 then 
        self.destroyed = true
    end       
end

function Plane:setTarget()
    self.direction = math.atan2(self.targetY-self.startY, self.targetX-self.startX)    
    self.vX = math.cos(self.direction) * self.speed
    self.vY = math.sin(self.direction) * self.speed
end

function Plane:destroy()
    Mob.destroy(self)
    if self.hit and not self.stage2 then            
        game.scenes.stages.score = game.scenes.stages.score + 15      
    end
end
