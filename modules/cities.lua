-- Gestion des villes
City = class.set()

function City:init()
    self.x = 0
    self.y = 0
    self.colliderX = 25
    self.colliderY = 12
    self.destroyed = false
    self.hit = false        
end    

function City:draw()
    gfx:setColor(255,255,255,255)
    if not self.destroyed then
        love.graphics.draw(images.city, self.x, self.y, 0, 1, 1, 25, 12)
    else
        love.graphics.draw(images.cityDestroyed, self.x, self.y+5, 0, 1, 1, 25, 7)
    end
end

function City:destroy()    
    audio.cityboom:stop()
    audio.cityboom:play()
    fx:add(class.new(Burst, self.x, self.y+15, 60, 2, 0))    
    fx:add(class.new(Burst, self.x+10, self.y+15, 45, 2, 20))    
    fx:add(class.new(Burst, self.x-5, self.y+15, 30, 3, 40))                                 
    fx:add(class.new(Smoke, self.x, self.y+25, 20, 1, 120, 20))               
    fx:add(class.new(Smoke, self.x+2, self.y, 30, 1, 120, 30))    
    fx:add(class.new(Smoke, self.x-5, self.y-25, 40, 1, 120, 40))   
end

Cities = class.set()
Cities.stack = {}    

function Cities:init()    
    self.stack = {}
    for i=1, 5 do
        self.stack[i] = class.new(City)        
    end
    self.stack[1].x = config.gameWidth/2 - 300
    self.stack[1].y = config.gameHeight - 88

    self.stack[2].x = config.gameWidth/2 - 150
    self.stack[2].y = config.gameHeight - 88

    self.stack[3].x = config.gameWidth/2
    self.stack[3].y = config.gameHeight - 88

    self.stack[4].x = config.gameWidth/2 + 150
    self.stack[4].y = config.gameHeight - 88

    self.stack[5].x = config.gameWidth/2 + 300
    self.stack[5].y = config.gameHeight - 88        
end

function Cities:update()
    for i=1, 5 do
        if self.stack[i].hit then
            if not self.stack[i].destroyed then
                self.stack[i]:destroy()               
            end
            self.stack[i].destroyed = true            
            game.scenes.stages:setTargets()
        end
    end
end

function Cities:draw()
    for i=1, 5 do
        self.stack[i]:draw()        
    end    
end

return class.new(Cities)
