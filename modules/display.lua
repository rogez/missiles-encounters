local display = {}
display.game = {}
display.window = {}

display.game.width, display.game.height = love.window.getMode()
display.game.rwidth, display.game.rheight = love.window.getMode()
display.scale, display.rscale = 1.0, 1.0
display.tx, display.ty = 0, 0
display.window.width, display.window.height = love.window.getMode()

function display.start()
    love.graphics.push()
    love.graphics.setColor(1,1,1,1)    
    love.graphics.translate(display.tx, display.ty)
    love.graphics.scale(display.scale, display.scale)    
end

function display.stop()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.scale(display.rscale, display.rscale)    
    if display.tx ~= 0 then
        love.graphics.rectangle("fill", -display.tx, 0, display.tx, display.window.height)
        love.graphics.rectangle("fill", display.game.rwidth, 0, display.tx, display.window.height)
    elseif display.ty ~= 0 then
        love.graphics.rectangle("fill", 0, -display.ty, display.window.width, display.ty)
        love.graphics.rectangle("fill", 0, display.game.rheight, display.window.width, display.ty)
    end
    love.graphics.pop()
end    

function display.resize(pw, ph)
    local w = pw or love.graphics.getWidth()
    local h = ph or love.graphics.getHeight()
    local sx = w / display.game.width
    local sy = h / display.game.height
    display.scale = math.min(sx, sy)
    display.rscale = 1 / display.scale

    if display.scale == sx then
        display.tx = 0
        display.ty = (h / 2) - (display.game.height * display.scale / 2)
    elseif display.scale == sy then
        display.ty = 0
        display.tx = (w / 2) - (display.game.width * display.scale / 2)
    end

    display.window.width = w
    display.window.height = h
    display.game.rwidth = display.game.width * display.scale
    display.game.rheight = display.game.height * display.scale    
end    

function display.game.coord(x, y)
    return math.floor((x - display.tx) / display.scale), math.floor((y - display.ty) / display.scale)
end

function display.window.coord(x, y)
    print(display.ty)
    return math.floor(x / display.scale + display.tx), math.floor(y / display.scale + display.ty)
end

return display