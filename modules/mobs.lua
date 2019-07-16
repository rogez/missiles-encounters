-- Différents ennemis
-- Système de "plugins perso" pour ajouter facilement des mobs plus tard
-- On ajoute dans la "stack" les différents ennemis et on les actives ensuite selon les besoins ou le bon timing
require("/modules/mobs/mob")
require("/modules/mobs/missile")
require("/modules/mobs/plane")
require("/modules/mobs/bomb")
require("/modules/mobs/redball")
require("/modules/mobs/ufo")

Mobs = class.set() 

function Mobs:init()
    self.stack = {}        
end

function Mobs:reset()
    self:init()
end

function Mobs:add(pMob)
    table.insert(self.stack, pMob)
end

function Mobs:update()               
    for k, v in pairs(self.stack) do                      
        if not v.destroyed then
            if not v.active and v.delay <= 0  then                    
                v:activate()                
            end                
            if v.active then
                v:update()                
            end                
            v.delay = v.delay - 1             
        else
            v:destroy()
            table.remove(self.stack, k)
        end               
    end
end 

function Mobs:draw()  
    for _, v in pairs(self.stack) do
        if v.active and v.delay<=0 then
            v:draw()               
        end
    end        
end

return class.new(Mobs)
