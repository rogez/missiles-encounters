-- Classe de base pour les mobs

Mob = class.set()

function Mob:init(pDelay, pX, pY)  
    self.level = game.scenes.stages.level
    self.score = 1

    -- Position fixée ou aléatoirement choisie
    self.x = pX or (100 + love.math.random(config.gameWidth-200))
    self.y = pY or (-10 - love.math.random(150))

    -- Position de départ mémorisée
    self.startX = self.x
    self.startY = self.y 
    self.delay = pDelay

    -- Vélocité et direction du mob calculés après que la cible soit connue
    self.vX = 0
    self.vY = 0   
    self.direction = 0                   
    -- self.speed = 0.3 + self.level/30 + love.math.random(10)/10

    self.speed = 0.5

    if self.level >=30 then
        self.speed = 1 + love.math.random(10)/10
    elseif self.level >=20 then
        self.speed = 0.9 + love.math.random(8)/10
    elseif self.level >=10 then
        self.speed = 0.8 + love.math.random(5)/10
    elseif self.level >=5 then
        self.speed = 0.7 + love.math.random(4)/10
    else 
        self.speed = 0.6 + love.math.random(2)/10
    end
    
    -- Position de la cible initialisée au moment de l'activation du mob
    self.targetX = 0
    self.targetY = 0

    self.active = false      -- afficher et gérer son déplacement
    self.hit = false         -- touché par un tir de joueur
    self.destroyed = false   -- destruction du mob

    -- Box de collision du mob par rapport au centre de l'image
    self.image = images.debug
    self.scale = 1       -- scale pour afficher le sprite dans le Draw
    self.colliderX = self.image:getWidth()/2 * self.scale
    self.colliderY = self.image:getHeight()/2 * self.scale
end

function Mob:update()
    self.x = self.x + self.vX        
    self.y = self.y + self.vY                              

    if self.y > config.gameHeight-150 then

        -- Test la collision avec les villes
        for i=1, 5 do
            if not cities.stack[i].destroyed and math2D:colliderRR(self.x, self.y, self.colliderX, self.colliderY, cities.stack[i].x, cities.stack[i].y, cities.stack[i].colliderX, cities.stack[i].colliderY) then
                cities.stack[i].hit = true
                self.destroyed = true
            end                
        end

        -- Test de la collision avec les bases

        if not bases.west.destroyed and math2D:colliderRR(self.x, self.y, self.colliderX, self.colliderY, bases.west.x, bases.west.y, bases.west.colliderX, bases.west.colliderY) then
            -- Explosion de la base west 
            bases.west.hit = true
            self.destroyed = true

        elseif not bases.east.destroyed and math2D:colliderRR(self.x, self.y, self.colliderX, self.colliderY, bases.east.x, bases.east.y, bases.east.colliderX, bases.east.colliderY) then
            -- Explosion de la base west                                 
            bases.east.hit = true
            self.destroyed = true
        end
    end

    -- Si le missile touche le sol
    if self.y > config.gameHeight-75 then 
        self.destroyed = true
    end        
end

function Mob:draw()                       
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y, self.direction, self.scale, self.scale, self.image:getWidth()/2, self.image:getHeight()/2)                        
end

function Mob:setTarget()

    if love.math.random(100) <= self.level then
        if #game.scenes.stages.targets.active > 0 then
            self.targetX = (game.scenes.stages.targets.active[love.math.random(#game.scenes.stages.targets.active)].x-15) + math.random(30) 
        else
            self.targetX = (game.scenes.stages.targets.stack[love.math.random(#game.scenes.stages.targets.stack)].x-15) + math.random(20) 
        end
    else
        self.targetX = love.math.random(config.gameWidth-20) + 10
    end

    self.targetY = config.gameHeight-100
    self.direction = math.atan2(self.targetY-self.startY, self.targetX-self.startX)    
    self.vX = math.cos(self.direction) * self.speed
    self.vY = math.sin(self.direction) * self.speed
end

function Mob:activate()
    self:setTarget()        
    self.active = true        
end

function Mob:destroy()
    if self.hit then
        game.scenes.stages.score = game.scenes.stages.score + self.score
    end
    audio.boom1:stop()
    audio.boom1:play()

    fx:add(class.new(Burst, self.x, self.y, 20, 0.7, 0))
    fx:add(class.new(Burst, self.x+love.math.random(30)-15, self.y+love.math.random(30)-15, 16, 1, 15))
    fx:add(class.new(Burst, self.x+love.math.random(30)-15, self.y+love.math.random(30)-15, 13, 2, 25))
    fx:add(class.new(Burst, self.x+love.math.random(30)-15, self.y+love.math.random(30)-15, 9, 3, 35))

    fx:add(class.new(Smoke, self.x, self.y, 10, 1, 120, 35))      
    fx:add(class.new(Smoke, self.x+love.math.random(16)-8, self.y+love.math.random(16)-8, 10, 1, 120, 40))      
    fx:add(class.new(Smoke, self.x+love.math.random(16)-8, self.y+love.math.random(16)-8, 10, 1, 120, 45))                  
end     
