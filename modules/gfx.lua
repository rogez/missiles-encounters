Gfx = class.set()

function Gfx:init()
    -- nop
end

function Gfx:setColor(r, g, b, z)
    love.graphics.setColor(r/255, g/255, b/255, z/255)
end

function Gfx:drawTarget(pX, pY, pSize)                
    pSize = pSize or 4 -- valeur par défaut
    gfx:setColor(love.math.random(1,255), 0, 0, 255)
    love.graphics.line(pX-pSize, pY, pX+pSize, pY)
    love.graphics.line(pX, pY-pSize, pX, pY+pSize)    
end

function Gfx:drawBlast(pX, pY, pSize)
    local color = love.math.random(101,200)

    gfx:setColor(0, 0, 0, 255)
    love.graphics.circle("fill", pX, pY, pSize+4)

    gfx:setColor(color+50, color-50, 0, 255)
    love.graphics.circle("fill", pX, pY, pSize)

    gfx:setColor(color+25, color-25, 0, 255)
    love.graphics.circle("fill", pX, pY, pSize-2)

    gfx:setColor(color+10, color-10, 0, 255)
    love.graphics.circle("fill", pX, pY, pSize-4)  
end

function Gfx:drawMissile(pX, pY, pDirection)
    gfx:setColor(255,255,255,255)
    love.graphics.draw(images.missile, pX, pY, pDirection, 1, 1, 13, 3)
end

return class.new(Gfx)
