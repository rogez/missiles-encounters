Bomb = class.set()

function Bomb:init(pX, pY, pDelay)
    self.level = game.scenes.stages.level

    -- Position fixée ou aléatoirement choisie
    self.x = pX or (100 + love.math.random(600))
    self.y = pY or (30 - love.math.random(100))

    -- Position de départ mémorisée
    self.startX = self.x
    self.startY = self.y 
    self.delay = pDelay

    -- Vélocité et direction du mob calculés après que la cible soit connue
    self.vX = 0
    self.vY = 0   
    self.direction = 0                   
    self.speed = 1

    -- Position de la cible initialisée au moment de l'activation du mob
    self.targetX = 0
    self.targetY = 0

    self.active = false      -- afficher et gérer son déplacement
    self.hit = false         -- touché par un tir de joueur
    self.destroyed = false   -- destruction du mob

    -- Box de collision du mob par rapport au centre de l'image
    self.scale = 1.5       -- scale pour afficher le sprite dans le Draw
    self.colliderX = images.bomb:getWidth()/2 * self.scale
    self.colliderY = images.bomb:getHeight()/2 * self.scale
end

function Bomb:update()        
    self.x = self.x + self.vX
    self.y = self.y + self.vY            

    if self.y > config.gameHeight - 150 then

        -- Test la collision avec les villes
        for i=1, 5 do
            if not cities.stack[i].destroyed and math2D:colliderRR(self.x, self.y, self.colliderX, self.colliderY, cities.stack[i].x, cities.stack[i].y, cities.stack[i].colliderX, cities.stack[i].colliderY) then
                cities.stack[i].hit = true
                self.destroyed = true

                -- Explosion de la ville
                audio.cityboom:stop()
                audio.cityboom:play()
                fx:add(class.new(Burst, cities.stack[i].x, cities.stack[i].y+15, 60, 2, 0))
                fx:add(class.new(Burst, cities.stack[i].x+10, cities.stack[i].y+15, 45, 2, 20))
                fx:add(class.new(Burst, cities.stack[i].x-5, cities.stack[i].y+15, 30, 3, 40))
                fx:add(class.new(Smoke, self.x, self.y+25, 20, 1, 120, 20))
                fx:add(class.new(Smoke, self.x+2, self.y, 30, 1, 120, 30))
                fx:add(class.new(Smoke, self.x-5, self.y-25, 40, 1, 120, 40))
            end                
        end

        -- Test de la collision avec les bases
        if not bases.west.destroyed and math2D:colliderRR(self.x, self.y, self.colliderX, self.colliderY, bases.west.x, bases.west.y, bases.west.colliderX, bases.west.colliderY) then
            -- Explosion de la base west
            fx:add(class.new(Burst, bases.west.x, bases.west.y, 90, 2, 0))  
            fx:add(class.new(Burst, bases.west.x+10, bases.west.y, 75, 2, 20))  
            fx:add(class.new(Burst, bases.west.x-5, bases.west.y, 40, 3, 40))  
            bases.west.hit = true  
            bases.west.hit = true

        elseif not bases.east.destroyed and math2D:colliderRR(self.x, self.y, self.colliderX, self.colliderY, bases.east.x, bases.east.y, bases.east.colliderX, bases.east.colliderY) then
            -- Explosion de la base west
            fx:add(class.new(Burst, bases.east.x, bases.east.y, 90, 2, 0))  
            fx:add(class.new(Burst, bases.east.x+10, bases.east.y, 75, 2, 20))  
            fx:add(class.new(Burst, bases.east.x-5, bases.east.y, 40, 3, 40))      
            bases.east.hit = true
        end

    end

    -- Si la bombe touche le sol
    if self.y > config.gameHeight - 75 then 
        self.destroyed = true
    end        
end

function Bomb:draw()    
    gfx:setColor(255,255,255,255)
    love.graphics.draw(images.bomb, self.x, self.y, 0, 1.5, 1.5, 4, 8)    
end

function Bomb:setTarget()                         
    self.targetY = config.gameHeight - 100
    self.targetX = self.x
    self.direction = math.atan2(self.targetY-self.startY, self.targetX-self.startX)          
    self.vX = math.cos(self.direction) * self.speed
    self.vY = math.sin(self.direction) * self.speed
end

function Bomb:activate()
    self:setTarget()        
    self.active = true        
end

function Bomb:destroy()           
    if self.hit then
        game.scenes.stages.score = game.scenes.stages.score + 1
    end
    audio.boom1:stop()
    audio.boom1:play()    
    fx:add(class.new(Burst, self.x, self.y, 20, 0.7, 0))      
    fx:add(class.new(Burst, self.x+10, self.y-5, 15, 2, 20))      
    fx:add(class.new(Burst, self.x-5, self.y+10, 10, 3, 40))      
    fx:add(class.new(Smoke, self.x, self.y, 10, 1, 120, 35))      
    fx:add(class.new(Smoke, self.x-5, self.y+10, 10, 1, 120, 40))      
    fx:add(class.new(Smoke, self.x+2, self.y-5, 10, 1, 120, 45))   
end
