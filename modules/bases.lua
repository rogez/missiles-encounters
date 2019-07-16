-- Gestion des bases EAST et WEST
-- Animation des canons pour un suivi du curseur

Base = class.set()

Base.x = 25
Base.y = config.gameWidth-75
Base.canon = {}
Base.canon.direction = 0
Base.canon.x = 0
Base.canon.y = 0
Base.colliderX = 35
Base.colliderY = 35
Base.destroyed = false
Base.hit = false
Base.ammos = 0

function Base:update()    
    local mx, my

    mx = mouse.x
    my = mouse.y

    if self.hit and not self.destroyed then
        audio.baseboom:stop()
        audio.baseboom:play()

        self:destroy()

        self.destroyed = true
        game.scenes.stages:setTargets()
    end   

    if not self.destroyed then 

        if self.x < config.gameWidth/2 then -- Base West
            self.canon.direction = math2D:angle(0, config.gameHeight-75, mouse.x, mouse.y)
            if self.canon.direction > 0 then
                self.canon.direction = 0
            end        
            self.canon.x = math2D:vx(self.canon.direction, 75)
            self.canon.y = math2D:vy(self.canon.direction, 75) + config.gameHeight-75

        else -- Base East
            self.canon.direction = math2D:angle(config.gameWidth, config.gameHeight-75, mouse.x, mouse.y)                            
            if self.canon.direction >= -math.pi/2 then
                self.canon.direction = -math.pi
            end
            self.canon.x = math2D:vx(self.canon.direction, 75) + config.gameWidth
            self.canon.y = math2D:vy(self.canon.direction, 75) + config.gameHeight - 75
        end                
    else
        self.ammos = 0
    end
end

function Base:fire()
    if not self.destroyed and self.ammos>0 and mouse.y < config.gameHeight-80 then
        audio.shoot:stop()
        audio.shoot:play()       
        counterMissiles:add(self.canon.x, self.canon.y, mouse.x, mouse.y)
        --fx:add(Burst(self.canon.x, self.canon.y, 15, 4, 0))            
        fx:add(class.new(Burst, self.canon.x, self.canon.y, 15, 4, 0))        
        self.ammos = self.ammos - 1                
    else
        audio.outofammo:stop()
        audio.outofammo:play()    
    end
end        

function Base:init(pX)
    self.x = pX -- 25 ou 775            
    self.y = config.gameHeight - 75
    self.canon = {}
    self.canon.direction = 0
    self.canon.x = 0
    self.canon.y = 0
    self.colliderX = 35
    self.colliderY = 35
    self.destroyed = false
    self.hit = false
    self.ammos = 0    
end   

function Base:destroy()
    fx:add(class.new(Burst, self.x, self.y, 90, 2, 0))  
    fx:add(class.new(Burst, self.x+10, self.y, 75, 2, 20))
    fx:add(class.new(Burst, self.x-5, self.y, 40, 3, 40))
end

Bases = class.set()

Bases.west = class.sub(Base)
Bases.east = class.sub(Base)   

function Bases:reset()
    self.west:init(25)
    self.east:init(config.gameWidth-25)
end

function Bases:update()
    self.west:update()
    self.east:update()
end

function Bases:init()
    self.west:init(25)
    self.east:init(config.gameWidth-25)
end

function Bases:draw()    
    if not self.west.destroyed then
        gfx:setColor(255,255,255,255)
        love.graphics.draw(images.canonBase, 0, config.gameHeight-75, self.west.canon.direction, 1, 1, 75, 5 )    
        love.graphics.draw(images.westBase, 25, config.gameHeight-100, 0, 1, 1, (images.westBase:getWidth())/2, (images.westBase:getHeight())/2 )
    end                
    if not bases.east.destroyed then        
        gfx:setColor(255,255,255,255)
        love.graphics.draw(images.canonBase, config.gameWidth, config.gameHeight-75, self.east.canon.direction, 1, 1, 75, 5 )    
        love.graphics.draw(images.eastBase, config.gameWidth-25, config.gameHeight-100, 0, 1, 1, (images.eastBase:getWidth())/2, (images.eastBase:getHeight())/2 )
    end            
    gfx:setColor(255,255,255,255)
end    

return class.new(Bases)
