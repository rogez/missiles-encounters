Debug = class.set()

function Debug:init()
    self.drawFPS = false    
end

local t=0
local st=0
function Debug:draw()
    t=t+1

    if t>60 then
        st = math.floor(game.sleepTime*1000000)/1000
        t=0
    end    

    if self.drawFPS then
        gfx:setColor(255,255,255,255)
        love.graphics.setFont(font16)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 5, 5)    
        love.graphics.print("SleepTime: "..tostring(st), 5, 30)        
    end
end

function Debug:toggleFPS()
    self.drawFPS = not self.drawFPS
end

return class.new(Debug)
