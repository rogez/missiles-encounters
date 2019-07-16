-- Premier écran, pas grand chose à voir ici :D
Start = class.set(Start)    

function Start:init()
    self.delay = 60*2
end

function Start:load()    
    self.delay = 60*2  -- en steps        
end

function Start:update()
    if self.delay == 0 then
        game.state = MAIN_MENU_LOAD
    else
        self.delay = self.delay - 1
    end
    --fx.Update()
end

function Start:draw()    
    --  fx.Draw()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.setFont(font96)
    love.graphics.printf("MISSILES", 0, config.gameHeight/2-90, config.gameWidth,"center", 0, 1, 1) 
    love.graphics.printf("ENCOUNTERS", 0, config.gameHeight/2, config.gameWidth,"center", 0, 1, 1)       
    love.graphics.setFont(font32)    
    love.graphics.setColor(0.4, 1, 0.4, 1)
    love.graphics.printf("Version "..GAME_VERSION, 0, config.gameHeight/2+100, config.gameWidth,"center", 0, 1, 1)
end

return class.new(Start)