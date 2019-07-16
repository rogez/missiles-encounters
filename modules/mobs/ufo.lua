Ufo = class.sub(Mob)

function Ufo:init(pDelay, pBeamSpeed, pX, pY)
    Mob.init(self, pDelay, pX, pY)

    self.stage2 = false  
    self.stage3 = false    
    self.beamY = 0
    self.beamSpeed = pBeamSpeed or 1
    self.speed = 5
    self.image = images.ufo    
    self.colliderX = self.image:getWidth()/2 * self.scale
    self.colliderY = self.image:getHeight()/2 * self.scale
end


function Ufo:update()
    Mob.update(self)

    if math2D:colliderRR(self.x, self.y, 2, 2, self.targetX, self.targetY, 2, 2) then
        self.vY = 0
        self.vX = 0
        self.x = self.targetX
        self.y = self.targetY
        self.stage2 = true
    end

    if self.stage2 and not self.stage3 then
        self.beamY = self.beamY + self.beamSpeed         
        audio.beam:stop()
        audio.beam:setVolume(0.15)
        audio.beam:setPitch(0.25)
        audio.beam:play()        
        -- Test la collision du rayon avec les villes
        for i=1, 5 do
            if not cities.stack[i].destroyed and math2D:colliderRR(self.x, self.y+self.beamY, 2, 2, cities.stack[i].x, cities.stack[i].y, cities.stack[i].colliderX, cities.stack[i].colliderY) then
                cities.stack[i].hit = true                
                self.stage3 = true
            end                
        end

        -- Test de la collision du rayon avec les bases    
        if not bases.west.destroyed and math2D:colliderRR(self.x, self.y+self.beamY, 2, 2, bases.west.x, bases.west.y, bases.west.colliderX, bases.west.colliderY) then
            -- Explosion de la base west 
            bases.west.hit = true
            self.stage3 = true
        elseif not bases.east.destroyed and math2D:colliderRR(self.x, self.y+self.beamY, 2, 2, bases.east.x, bases.east.y, bases.east.colliderX, bases.east.colliderY) then
            -- Explosion de la base west                                 
            bases.east.hit = true
            self.stage3 = true
        end
        if (self.y + self.beamY) > config.gameHeight-25 then
            self.stage3 = true
        end

    elseif self.stage3 then
        -- L'ufo repart vers une autre cible
        self.startX = self.x
        self.startY = self.y
        self:setTarget()    
        self.stage2 = false
        self.stage3 = false
        self.beamY = 0
    end
end

function Ufo:setTarget()        
    audio.ufo:stop()
    audio.ufo:play()

    if #game.scenes.stages.targets.active > 0 then
        self.targetX = (game.scenes.stages.targets.active[love.math.random(#game.scenes.stages.targets.active)].x)
    else
        self.targetX = (game.scenes.stages.targets.stack[love.math.random(#game.scenes.stages.targets.stack)].x)
    end               
    self.targetY = 100 + math.random(180)
    self.direction = math.atan2(self.targetY-self.startY, self.targetX-self.startX)    
    self.vX = math.cos(self.direction) * self.speed
    self.vY = math.sin(self.direction) * self.speed    
end

function Ufo:draw()                      
    if self.stage2 then
        for i=1, 20 do
            gfx:setColor(255,math.random(180),math.random(100),255)            
            love.graphics.line(self.x, self.y, self.x, self.y+self.beamY)
            gfx:setColor(255,math.random(180),math.random(100),255)            
            love.graphics.line(self.x, self.y, self.x+i, self.y+self.beamY)
            gfx:setColor(255,math.random(180),math.random(100),255)            
            love.graphics.line(self.x, self.y, self.x-i, self.y+self.beamY)
        end               
    end            
    gfx:setColor(255,255,255,255)
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale, self.image:getWidth()/2, self.image:getHeight()/2)        
end
