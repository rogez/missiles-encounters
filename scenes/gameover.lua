-- Gestion de l'écran de GAME OVER
GameOver = class.set()

function GameOver:init()
    -- nop
end

function GameOver:load()
    audio.gameover:stop()
    audio.gameover:play() 
end

function GameOver:update()
    if mouse.button1.click or mouse.button2.click then
        game.state = MAIN_MENU_LOAD
    end        
end

function GameOver:draw()    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(font64)
    love.graphics.printf("GAME OVER !",0, 200, config.gameWidth,"center", 0, 1, 1) 
    love.graphics.printf("SCORE : "..tostring(game.scenes.stages.score),0, 300, config.gameWidth,"center", 0, 1, 1) 

    if game.scenes.stages.score > game.bestScore then
        love.graphics.setFont(font32)        
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf("NOUVEAU RECORD !", 0, 390, config.gameWidth,"center", 0, 1, 1) 
    end        

    mouse:draw()
end

return class.new(GameOver)
