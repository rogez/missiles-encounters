Pause = class.set()   

function Pause:init()
    self.screenshot = 0
end


function Pause:load()
    self.startOnOver = false
    self.quitOnOver = false
    love.mouse.setGrabbed(false)
    mouse.instage = false
end

function Pause:update()

    if mouse.x >= config.gameWidth/2-200 and mouse.x <= config.gameWidth/2+200 and mouse.y >= 360 and mouse.y <= 410 then
        self.quitOnOver = true
        if mouse.button1.click then
            game.state = MAIN_MENU_LOAD                
        end
    else
        self.quitOnOver = false
    end


    if mouse.x >= config.gameWidth/2-200 and mouse.x <= config.gameWidth/2+200 and mouse.y >= 300 and mouse.y <= 350 then
        self.startOnOver = true
        if mouse.button1.click then
            game.state = STAGE
            love.mouse.setGrabbed(true)
            mouse.instage = true        
        end
    else
        self.startOnOver = false
    end 


end

function Pause:draw()

    game.scenes.stages:draw()   

    love.graphics.setColor(1/-91, 1/255, 1/255, 13/219)
    love.graphics.rectangle("fill", 0, 0, config.gameWidth, config.gameHeight)

    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(font128)
    love.graphics.printf("PAUSE",0, 150, config.gameWidth,"center", 0, 1, 1) 

    if not self.startOnOver then        
        love.graphics.setColor(1,1,1,1)        
    else        
        love.graphics.setColor(1,0,0,1)
    end               

    love.graphics.rectangle("fill", config.gameWidth/2-200, 300, 400, 50)
    love.graphics.setColor(0, 0, 0, 1)

    love.graphics.rectangle("line", config.gameWidth/2-198, 302, 396, 46)
    love.graphics.setColor(1.1,1,1,1)

    love.graphics.setFont(font32)    
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("REPRENDRE", 0, 305, config.gameWidth,"center", 0, 1, 1)       

    if not self.quitOnOver then        
        love.graphics.setColor(1, 1, 1, 1)
    else        
        love.graphics.setColor(1, 0, 0, 1)
    end      

    love.graphics.rectangle("fill", config.gameWidth/2-200, 360, 400, 50)    
    love.graphics.setColor(0, 0, 0, 1)    
    love.graphics.rectangle("line", config.gameWidth/2-198, 362, 396, 46)    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font32)    
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("QUITTER", 0, 365, config.gameWidth,"center", 0, 1, 1)

    mouse:draw()
end

return class.new(Pause)