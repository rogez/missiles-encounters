-- Quelques fonctions mathématiques bien utiles...
-- Formules trouvées sur : https://love2d.org/wiki/General_math
--
-- TODO : il reste dans le code des duplications

Math2D = class.set()

function Math2D:init()
    -- nop
end

-- Angle entre deux points
function Math2D:angle(x1,y1, x2,y2)
    return math.atan2(y2-y1, x2-x1)
end

-- Distance entre deux points
function Math2D:dist(x1,y1, x2,y2)
    return ((x2-x1)^2+(y2-y1)^2)^0.5
end

-- Retourne le déplacement en X d'un vecteur d'après son angle et une vélocité ou une distance (v)
function Math2D:vx(angle, v)    
    return math.cos(angle) * v
end

-- Retourne le déplacement en Y d'un vecteur d'après son angle et une vélocité ou une distance (v)
function Math2D:vy(angle, v)    
    return math.sin(angle) * v
end

-- Test la collision entre un cercle et un rectangle
-- TODO : réfléchir à l'optimisation (codé en vitesse sans trop chercher à optimiser quoi que ce soit pour la jam...)
--        vu le faible nombre d'objets à l'écran, ne devrait pas poser de problème pour l'instant.

function Math2D:colliderCR(cX, cY, cR, rX, rY, tX, tY)
    local angle = math2D:angle(cX, cY, rX, rY)
    local pX = math2D:vx(angle, cR)
    local pY = math2D:vy(angle, cR)
    pX = pX + cX
    pY = pY + cY
    local result    
    if (pX <= (rX+tX)) and (pX >= (rX-tX)) and (pY <= (rY+tY)) and (pY >= (rY-tY)) then 
        result = true
    else
        result = false
    end
    return result
end

-- Test la collision entre deux rectangles
function Math2D:colliderRR(r1X, r1Y, t1X, t1Y, r2X, r2Y, t2X, t2Y)
    if ((r1X+t1X) >= (r2X-t2X)) and ((r1X-t1X) <= (r2X+t2X)) and ((r1Y+t1Y) >= (r2Y-t2Y)) and ((r1Y-t1Y) <= (r2Y+t2Y)) then
        result = true
    else
        result = false
    end    
    return result
end

return class.new(Math2D)
