-- Gestion des contre-missiles lancés par le joueur

CounterMissiles = class.set()

function CounterMissiles:init()
    self.stack = {}
    self.speedVelocity = 12  -- Vitesse d'un missile
    self.speedBlast = 1.5    -- Vitesse d'expansion d'un "blast" de missile
    self.blastSize = 40      -- Taille d'un "blast" de missile
    self.blastTimeout = 0.4  -- Durée du maintient du blast en secondes
end

function CounterMissiles:add(pStartX, pStartY, pTargetX, pTargetY)

    local newMissile = {}        
    local newDirection, newDistanceTarget, newVx, newVy

    newDirection = math.atan2(pTargetY-pStartY, pTargetX-pStartX)        
    newVx = math.cos(newDirection) * counterMissiles.speedVelocity
    newVy = math.sin(newDirection) * counterMissiles.speedVelocity
    newDistanceTarget = ((pTargetX-pStartX)^2+(pTargetY-pStartY)^2)^0.5

    newMissile = {              startX = pStartX, -- Position de départ
        startY = pStartY,
        targetX = pTargetX, -- Cible
        targetY = pTargetY,                                    
        x = pStartX, -- Position courante
        y = pStartY,                                    
        direction = newDirection,
        distanceTarget = newDistanceTarget,
        distanceCovered = 0,
        vX = newVx,          -- Vélocité
        vY = newVy,
        targetReached = false, -- Cible atteinte
        blast = false,    -- Blast en ours
        rBlast = 0,   -- Rayon du blast
        vBlast = 0,  -- Vitesse de la croissance du blast
        blastTime = 0, -- Combien de temps maintenair le blast à sa taille maxi 
        blastEnd = false  -- Fin du blast
    }    
    table.insert( self.stack, newMissile )          
end

function CounterMissiles:update()
    for k, v in pairs(self.stack) do        
        if not v.targetReached then
            local newDistance = ((v.x-v.startX)^2+(v.y-v.startY)^2)^0.5
            if newDistance >= v.distanceTarget then
                v.targetReached = true                      
                v.x = v.targetX
                v.y = v.targetY                
            else                
                v.x = v.x + v.vX/2 
                v.y = v.y + v.vY/2                
                fx:add(class.new(Smoke, v.x, v.y, 3, 2, 120, 3))
                v.x = v.x + v.vX
                v.y = v.y + v.vY               
                fx:add(class.new(Smoke, v.x, v.y, 3, 2, 120, 3))

                --fx:add(class.new(SmokeLine, v.x, v.y, 3, 0.1, 370, 5))    
                v.distanceCovered = ((v.x-v.startX)^2+(v.y-v.startY)^2)^0.5
            end
        else
            if not v.blast  then
                v.blast = true
                v.rBlast = 0
                v.vBlast = self.speedBlast                    
            else
                if v.vBlast > 0 then
                    if v.rBlast < self.blastSize then
                        v.rBlast = v.rBlast + v.vBlast
                    else
                        v.rBlast = self.blastSize
                        v.vBlast = 0 - v.vBlast                    
                    end
                else
                    if v.rBlast > 0 then
                        v.rBlast = v.rBlast + (v.vBlast * 2.5)
                    else
                        v.blastEnd = true
                    end                    
                end                
            end

            --Check Collisions

            for _, vmob in pairs(mobs.stack) do               
                if v.rBlast then
                    if math2D:colliderCR(v.x, v.y, v.rBlast, vmob.x, vmob.y, vmob.colliderX, vmob.colliderY) then  
                        vmob.hit = true
                        vmob.destroyed = true
                    end
                end
            end                   
        end
        if v.blastEnd then
            table.remove(self.stack, k)
        end
    end        
end

function CounterMissiles:draw()    
    for _, v in pairs(self.stack) do           
        if v.blast and ( not v.blastEnd) then                
            gfx:drawBlast(v.x, v.y, v.rBlast)
        else
            gfx:drawTarget(v.targetX, v.targetY)
            gfx:setColor(50,50,50,255)
            gfx:drawMissile(v.x, v.y, v.direction)  
            gfx:setColor(255,255,255,255)
            love.graphics.draw(images.missile, v.x, v.y, v.direction, 1, 1, 13, 3)            
        end                       
    end
    gfx:setColor(255,255,255,255)
end

return class.new(CounterMissiles)
