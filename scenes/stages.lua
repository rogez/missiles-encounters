-- Gestion, création des stages, vagues d'ennemis, gestion du level etc...

STAGE_TEST = 0 -- uniquement pour des tests

Stages = class.set()

function Stages:init()
    self.targets = {}
    self.targets.stack ={}
    self.targets.active ={}

    self.level = 1
    self.score = 0
    self.gameStep = 0

    self.victory = false
    self.vStepAnim = 0
    self.gameOver = false
    self.gameOverTimer = 60
end

function Stages:load()        
    love.mouse.setGrabbed(true)

    self.gameOver = false
    self.gameOverTimer = 60
    self.victory = false
    self.score = 0
    self.vStepAnim = 0
    self.gameStep = 0
    self.level = 1

    mobs:reset()
    fx:init()
    cities:init()    
    bases:reset()
    counterMissiles:init()

    self:setTargets()    
    self:setLevel(self.level)
end

function Stages:update()

    self.gameStep = self.gameStep + 1

    mobs:update()                      
    counterMissiles:update()

    if not self.gameOver then
        if not self.victory then
            bases:update()
            cities:update()
            if mouse.button1.click then
                bases.west:fire()
            end
            if mouse.button2.click then            
                bases.east:fire()
            end                  
        else
            -- Gagné, niveau suivant !
        end

    else
        self.gameOverTimer = self.gameOverTimer - 1

        if self.gameOverTimer <= 0 then
            game.state = GAME_OVER_LOAD
        end        
    end

    if #mobs.stack <= 0 and not self.gameOver then
        self.victory = true            
    end

    if self.victory then                      
        if self.vStepAnim >= 60*3 then
            self.level = self.level + 1                       
            self:setLevel(self.level)
        end                
        self.vStepAnim = self.vStepAnim + 1                        
    end       

    fx:update()

end

function Stages:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(images.background1, 0,0)    

    cities:draw()
    bases:draw()
    counterMissiles:draw()
    fx:draw()
    mobs:draw()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(images.ui, 0,0)

    love.graphics.setFont(font32)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.printf("SCORE : "..tostring(self.score), 0, config.gameHeight-50, config.gameWidth,"center", 0, 1, 1) 
    love.graphics.printf(tostring(bases.west.ammos), 20, config.gameHeight-40, 750,"left", 0, 1, 1) 
    love.graphics.printf(tostring(bases.east.ammos), 0, config.gameHeight-40, config.gameWidth-20,"right", 0, 1, 1)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(images.missile, 35, config.gameHeight-45, -math.pi/4, 1, 1)
    love.graphics.draw(images.missile, config.gameWidth-45, config.gameHeight-45, -math.pi/4, 1, 1)

    love.graphics.setFont(font64)
    love.graphics.setColor(1, 1, 1, 1)

    if self.gameStep < 120 then       
        love.graphics.printf("LEVEL "..tostring(self.level), 0, 200, config.gameWidth,"center", 0, 1, 1)           
    else       
        gfx:setColor(0, 255, 0 , 255)
        love.graphics.setFont(font24)
        love.graphics.printf("LEVEL  "..tostring(self.level), 0, 15, config.gameWidth-50,"right", 0, 1, 1)
    end
    mouse:draw()
end

function Stages:setLevel(pLevel)
    local k
    local ammoSup = 0

    self.gameOver = false
    self.gameOverTimer = 60
    self.victory = false
    self.vStepAnim = 0
    self.gameStep = 0

    mobs:reset()
    fx:init()
    bases:reset()
    if pLevel== 1 then
        cities:init()
    else
        audio.levelup:play()
    end  

    -- Construction des vagues d'ennemis -----------    

    -- level 1-9 k = 0, level 10-19 k = 1 ...
    k = math.floor(self.level/10)
    if k >= 3 then
        k = 3        
    end       

    if self.level >=20 then
        ammoSup = ammoSup + 16
    elseif self.level >= 10 then
        ammoSup = ammoSup + 10
    elseif self.level >= 5 then
        ammoSup = ammoSup + 6
    end

    if STAGE_TEST >= 1 then
        -- tests
    else

        -- VAGUE 1 --------------------------------

        self:addMissile(60, 7)
        self:addMissile(60*5, 7)
        if  self.level >= 3 then
            self:addUfo(60*7, 1.5+k/3, 1+k)
        end

        -- VAGUE 2 ------------------------------
        if self.level >= 3 then
            self:addMissile(60*10, 7)        
            self:addMissile(60*17, 7+k)
            self:addRedball(60*20, 3+k)
            ammoSup = ammoSup + 5 + k*2
        end

        -- VAGUE 3 -----------------------------------
        if self.level >= 5 then        
            self:addMissile(60*30, 7)        
            if math.random(3) <= 2 then
                self:addPlane(60*32, 1+k)
            else            
                self:addUfo(60*34, 1.5+k/3, 1+k)
                self:addUfo(60*37, 1.5+k/3, 1+k)
            end        
            ammoSup = ammoSup + 3*k        
        end

        -- VAGUE 4 --------------------------------------
        if self.level >= 10 then    
            self:addMissile(60*42, 7+(k*2))                
            self:addMissile(60*48, 7)        

            self:addPlane(60*48, 1+k)
            ammoSup = ammoSup + 3*k        

            self:addRedball(60*53, 3+k)
            ammoSup = ammoSup + k
        end           

        bases.east.ammos = math.floor(#mobs.stack) +  ammoSup + 5*k
        bases.west.ammos = math.floor(#mobs.stack) +  ammoSup + 5*k    
    end

end

-- Permet de raffraichir la liste des cibles (cités et bases) disponibles pour les mobs
--
function Stages:setTargets()   
    self.targets.stack = {}
    self.targets.active = {}
    for i=1, 5 do
        table.insert(self.targets.stack, cities.stack[i])
        if not cities.stack[i].destroyed then
            table.insert(self.targets.active, cities.stack[i])
        end            
    end

    if #self.targets.active <= 0 and not self.gameOver then            
        self.gameOver = true        
    end        

    table.insert(self.targets.stack, bases.west)
    table.insert(self.targets.stack, bases.east)
    if not bases.west.destroyed then
        table.insert(self.targets.active, bases.west)
    end        
    if not bases.east.destroyed then
        table.insert(self.targets.active, bases.east)
    end        
end

function Stages:addMissile(pDelay, n)
    n = n or 1
    for _=1, n do        
        mobs:add(class.new(Missile, pDelay))               
    end     
end

function Stages:addPlane(pDelay, n)
    n = n or 1
    local j = 45
    for i=1, n do        
        mobs:add(class.new(Plane, pDelay+j))                
        j = j + 45
    end     
end

function Stages:addRedball(pDelay, n)
    n = n or 1
    for i=1, n do        
        mobs:add(class.new(Redball, pDelay+i*5))        
    end     
end

function Stages:addUfo(pDelay, pBeamSpeed, n)
    n = n or 1
    for i=1, n do        
        mobs:add(class.new(Ufo, pDelay+i*5, pBeamSpeed))
    end
end

return class.new(Stages)
