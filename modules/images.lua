Images = class.set()

-- Fonction pour coder simplement une couleur sur 3 chiffres pour les matrices
-- Largement suffisant pour ce projet
-- 0 = transparent

function Images:setColor(pColor)
    local red, green, blue

    red = math.floor(pColor/100)
    green = math.floor(pColor/10) - (red*10)
    blue = math.floor(pColor - (red*100) - (green*10))

    if red ~= 0 then
        red = (red * 28) + 3
    end

    if green ~= 0 then
        green = (green * 28) + 3
    end

    if blue ~= 0 then
        blue = (blue * 28) + 3
    end

    if red ==0 and green ==0 and blue ==0 then
        alpha = 0
    else
        alpha = 255
    end        

    gfx:setColor(red, green, blue, alpha)        
end    

-- Transforme un tableau à deux dimensions en points de couleurs
-- retourne les dimensions de l'image    
function Images:tabPoints(pT)
    local l, c

    for l=1, #pT do
        for c=1, #pT[l] do
            self:setColor(pT[l][c])
            love.graphics.points(c-1, l-1)
        end
    end
    return #pT[1], #pT
end    

function Images:init()
    local canvas = love.graphics.newCanvas(config.gameWidth,config.gameHeight)
    local t = {}
    local i, imgWidth, imgHeight

    love.graphics.setCanvas(canvas)            
    love.graphics.setBlendMode("alpha")

-- Background 1
    love.graphics.clear()
    gfx:setColor(7,7,18,150)
    love.graphics.rectangle("fill", 0, 0, config.gameWidth, config.gameHeight)
    for i=300, config.gameHeight do
        gfx:setColor(13,13,13,i-350)        
        love.graphics.line(0,i,config.gameWidth,i)        
    end

    for i=1, 75 do
        local col = love.math.random(75)       
        gfx:setColor(col, col - love.math.random(20), col - love.math.random(20), 255)                
        love.graphics.circle("fill", love.math.random(config.gameWidth-1), love.math.random(config.gameHeight-50),love.math.random(2))
    end         

    for i=1, 120 do
        local col = love.math.random(80)       
        gfx:setColor(col, col - love.math.random(20), col - love.math.random(20), 255)                
        love.graphics.circle("fill", love.math.random(config.gameWidth-1), love.math.random(config.gameHeight-200),love.math.random(2))
    end         

    for i=1, 120 do
        local col = love.math.random(90)       
        gfx:setColor(col, col - love.math.random(20), col - love.math.random(20), 255)                
        love.graphics.circle("fill", love.math.random(config.gameWidth-1), love.math.random(200),love.math.random(2))
    end         
    love.graphics.setCanvas()
    self.background1 = love.graphics.newImage(canvas:newImageData( nil, 1, 0, 0, config.gameWidth, config.gameHeight ))

-- UI ----
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()

    gfx:setColor(40, 180, 5, 255)
    love.graphics.line(0,config.gameHeight-75,config.gameWidth,config.gameHeight-75)

    gfx:setColor(40, 65, 65, 255) 
    love.graphics.rectangle("fill", 0, config.gameHeight-75, config.gameWidth, config.gameHeight)                      

    gfx:setColor(70, 40, 10, 255)
    love.graphics.rectangle("fill", 0, config.gameHeight-75, config.gameWidth, 15) 

    gfx:setColor(40, 180, 5, 255)
    love.graphics.line(0,config.gameHeight-74,config.gameWidth,config.gameHeight-74)

    love.graphics.setCanvas()
    self.ui = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, config.gameWidth, config.gameHeight ))

-- West Base
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    gfx:setColor(50, 75, 75, 255)           
    love.graphics.circle("fill", 0, 50, 50)
    gfx:setColor(40, 65, 65, 255) 
    love.graphics.circle("fill", 0, 50, 40)
    love.graphics.setCanvas()
    self.westBase = love.graphics.newImage(canvas:newImageData(nil,1,0,0, 50, 50 ))

-- East Base
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    gfx:setColor(50, 75, 75, 255)           
    love.graphics.circle("fill", config.gameWidth, 50, 50)
    gfx:setColor(40, 65, 65, 255) 
    love.graphics.circle("fill", config.gameWidth, 50, 40)
    love.graphics.setCanvas()
    self.eastBase = love.graphics.newImage(canvas:newImageData(nil,1, config.gameWidth-50, 0, 50, 50 ))

-- Base (canon)
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    gfx:setColor(30, 60, 60, 255)        
    love.graphics.rectangle("fill", 0, 0, 150, 10)
    love.graphics.setCanvas()
    self.canonBase = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, 150, 10 ))

-- Cité OK
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    gfx:setColor(100, 100, 100, 255)
    love.graphics.rectangle("fill", 0, 0, 50, 25)                      

    gfx:setColor(255, 255, 0, 255)
    love.graphics.rectangle("fill", 5, 5, 5, 5)                      
    love.graphics.rectangle("fill", 15, 5, 5, 5) 
    love.graphics.rectangle("fill", 30, 5, 5, 5) 
    love.graphics.rectangle("fill", 40, 5, 5, 5) 
    love.graphics.rectangle("fill", 5, 15, 5, 5)                      
    love.graphics.rectangle("fill", 15, 15, 5, 5) 
    love.graphics.rectangle("fill", 30, 15, 5, 5) 
    love.graphics.rectangle("fill", 40, 15, 5, 5) 
    love.graphics.setCanvas()
    self.city = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, 50, 25))

-- Cité HS
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    gfx:setColor(50, 50, 50, 255)
    love.graphics.rectangle("fill", 0, 0, 10, 15)                      
    love.graphics.rectangle("fill", 10, 5, 10, 10)                      
    love.graphics.rectangle("fill", 20, 3, 10, 12)                      
    love.graphics.rectangle("fill", 30, 10, 10, 5)                      
    love.graphics.rectangle("fill", 40, 7, 10, 8) 
    love.graphics.setCanvas()
    self.cityDestroyed = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, 50, 15))

-- Missile
--    love.graphics.setCanvas(canvas)   
--    love.graphics.clear()
--    t =         {   
--                    {999, 999, 999, 333, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
--                    {333, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 555, 111, 000 },
--                    {000, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 555 },
--                    {000, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777 },
--                    {000, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 555 },
--                    {333, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 555, 111, 000 },
--                    {999, 999, 999, 333, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 }                           
--                }

--    imgWidth, imgHeight = self:tabPoints(t)
--    love.graphics.setCanvas()
--    self.missile = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, imgWidth, imgHeight))

    self.missile = love.graphics.newImage("images/missile.png")


-- Avion
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    t =         {   
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {777, 777, 777, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {777, 777, 777, 777, 777, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {777, 777, 777, 777, 777, 777, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 555, 777, 777, 777, 555, 555, 555, 000, 000 },
        {000, 555, 555, 555, 555, 555, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 555, 555, 555, 555, 000 },
        {000, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777 },
        {000, 000, 000, 777, 777, 777, 777, 777, 777, 555, 555, 555, 555, 555, 555, 555, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 777, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 777, 777, 777, 777, 777, 777, 777, 777, 555, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 777, 777, 777, 777, 777, 777, 777, 777, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 777, 777, 777, 777, 777, 777, 777, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },                            
        {000, 000, 000, 000, 000, 777, 777, 777, 777, 777, 777, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 }                            
    }

    imgWidth, imgHeight = self:tabPoints(t)
    love.graphics.setCanvas()
    self.plane = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, imgWidth, imgHeight))


    -- UFO
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    t =  {
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 339, 009, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 009, 339, 009, 009, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 009, 339, 009, 009, 009, 009, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 009, 009, 339, 009, 009, 009, 009, 009, 009, 009, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 009, 009, 009, 009, 009, 009, 009, 009, 009, 009, 009, 009, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 999, 999, 999, 999, 999, 999, 999, 999, 999, 666, 009, 009, 009, 009, 009, 009, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000, 000, 000 },
        {000, 999, 999, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 444, 009, 009, 009, 009, 444, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000 },
        {666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 444, 444, 444, 444, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666 },
        {000, 000, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000, 000 },
        {000, 000, 000, 000, 000, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000, 000, 000, 000, 000, 000, 000, 000 },
        {000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 666, 666, 666, 666, 666, 666, 666, 666, 666, 666, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000, 000 }

    }

    imgWidth, imgHeight = self:tabPoints(t)
    love.graphics.setCanvas()
    self.ufo = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, imgWidth, imgHeight))




-- Bomb
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    t =         {   
        {000, 555, 555, 000, 000, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 555, 555, 000, 000, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 000, 555, 555, 555, 555, 000, 000 },
        {000, 000, 333, 555, 555, 333, 000, 000 },
        {000, 000, 333, 555, 555, 333, 000, 000 },
        {000, 333, 333, 333, 333, 333, 333, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 555, 555, 555, 555, 555, 555, 000 },
        {000, 000, 555, 555, 555, 555, 000, 000 },
    }

    imgWidth, imgHeight = self:tabPoints(t)
    love.graphics.setCanvas()
    self.bomb = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, imgWidth, imgHeight))

-- Mob Redball
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()            

    gfx:setColor(255, 255, 255, 255)            
    love.graphics.line(0,20,15,20)
    love.graphics.line(25,20,40,20)
    love.graphics.line(20,0,20,15)
    love.graphics.line(20,25,20,40)

    gfx:setColor(255, 0, 0, 255)            
    love.graphics.circle("line", 20, 20, 15)
    love.graphics.circle("fill", 20, 20, 13)
    love.graphics.setCanvas()
    self.redBall = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, 40, 40 ))

-- Image Test, un simple carré 25x25 pour tester de nouveaux mobs
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()
    gfx:setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, 25, 25)   
    love.graphics.setCanvas()
    self.debug = love.graphics.newImage(canvas:newImageData(nil,1, 0, 0, 25, 25 ))

-- Curseur Viseur (format ImageData)
-- Attention ce n'est pas une image mais des datas pour le curseur en forme de cible
    love.graphics.setCanvas(canvas)   
    love.graphics.clear()            
    gfx:setColor(0, 255, 0, 255)            
    love.graphics.circle("line", 20, 20, 15)
    love.graphics.circle("line", 20, 20, 14)
    love.graphics.line(0,20,15,20)
    love.graphics.line(25,20,40,20)
    love.graphics.line(20,0,20,15)
    love.graphics.line(20,25,20,40)
    love.graphics.setCanvas()
    self.viewFinder = canvas:newImageData(nil,1, 0, 0, 40, 40 )            
    self.viewFinderImg = love.graphics.newImage(self.viewFinder)

    canvas = nil
end

return class.new(Images)
