Keyboard = class.set()

function Keyboard:init()
    -- nop
end

function Keyboard:keypressed(k)

    if game.state == STAGE and k == "escape" then
        game.state = PAUSE_LOAD
    elseif game.state == PAUSE then
        game.state = STAGE
        love.mouse.setGrabbed(true)
        mouse.instage = true
    end

    if game.state == MAIN_MENU and k == "escape" then
        love.event.quit(0)
    end

    if game.state == GAME_OVER then
        game.state = MAIN_MENU_LOAD
    end

    if k == "f" then
        debug:toggleFPS()
    end    
end

return class.new(Keyboard)
