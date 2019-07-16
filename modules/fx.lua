-- codage des "effets spéciaux" à base de cercles pour coller au thème de la jam

require("modules/fx/burst")    
require("modules/fx/smoke")
require("modules/fx/smokeLine")

Fx = class.set()

function Fx:init()
    self.stack = {}   
end

function Fx:update()
    local k, v

    for k, v in pairs(self.stack) do               
        if v.active == true  then
            if v.delay <= 0 then
                v:update()                                
            else
                v.delay = v.delay - 1
            end            
        else
            table.remove(self.stack, k)
        end               
    end    
end

function Fx:draw()
    local k, v

    for k, v in pairs(self.stack) do         
        if v.delay <= 0 then
            v:draw()
        end
    end
end

function Fx:add(pFx)
    table.insert(self.stack, pFx)
end

return class.new(Fx)
