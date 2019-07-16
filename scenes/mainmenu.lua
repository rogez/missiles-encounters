-- Gestion du menu principal
MainMenu = class.set()

function MainMenu:init()
    self.startOnOver = false
end

function MainMenu:load()    
    local writeFile = false
    local save = class.new(Save)

    self.startOnOver = false
    audio.boom1:play()    
    love.mouse.setGrabbed(false)    

    game.bestScore, game.bestLevel = save:read()

    if game.scenes.stages.score > game.bestScore then
        game.bestScore = game.scenes.stages.score            
        writeFile = true
    end
    if game.scenes.stages.level > game.bestLevel then
        game.bestLevel = game.scenes.stages.level
        writeFile = true
    end               

    if writeFile then
        save:write(game.bestScore, game.bestLevel)
    end               

end

function MainMenu:update()

    --  fx.Update()

    if mouse.x >= 250 and mouse.x <= config.gameWidth-250 and mouse.y >= 250 and mouse.y <= 310 then
        self.startOnOver = true
        if mouse.button1.click then
            game.state = STAGE_LOAD                
        end
    else
        self.startOnOver = false
    end        
end

function MainMenu:draw()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(images.background1, 0,0)     
    love.graphics.setFont(font64)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf("MISSILES", 0, 50, config.gameWidth,"center", 0, 1, 1) 
    love.graphics.printf("ENCOUNTERS", 0, 120, config.gameWidth,"center", 0, 1, 1) 

    if not self.startOnOver then        
        love.graphics.setColor(1, 1, 1, 1)
    else
        gfx:setColor(255, 0 , 0 , 255)
        love.graphics.setColor(1, 0, 0, 1)
    end

    love.graphics.rectangle("line", 250, 250, config.gameWidth-500, 60)
    love.graphics.rectangle("fill", 254, 254, config.gameWidth-(254*2), 52)

    gfx:setColor(255, 255 , 255 , 255)

    love.graphics.setFont(font32)
    gfx:setColor(0, 0 , 0 , 255)
    love.graphics.printf("NOUVELLE PARTIE", 0, 260, config.gameWidth,"center", 0, 1, 1) 

    love.graphics.setFont(font24)
    gfx:setColor(0, 255 , 0 , 255)
    love.graphics.printf("MEILLEUR SCORE : ".. tostring(game.bestScore), 0, 330, config.gameWidth,"center", 0, 1, 1) 
    love.graphics.printf("PLUS HAUT NIVEAU ATTEINT : ".. tostring(game.bestLevel), 0, 360, config.gameWidth,"center", 0, 1, 1) 

    gfx:setColor(255, 255 , 255 , 255)
    love.graphics.printf("Copyright © "..COPY_YEARS.."   -   Fredy Rogez", 0, config.gameHeight-45, config.gameWidth,"center", 0, 1, 1) 

    love.graphics.setFont(font16)
    gfx:setColor(255, 0 , 0 , 255)
    love.graphics.printf("Version "..GAME_VERSION, 0, 190, 650, "right", 0, 1, 1)     

    mouse:draw()
end

return class.new(MainMenu)
