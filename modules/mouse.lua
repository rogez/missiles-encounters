Mouse = class.set()

function Mouse:init()
    self.x = 0
    self.y = 0  
    self.button1 = { newClick = false, click = false}
    self.button2 = { newClick = false, click = false}
    self.instage = false
end

function Mouse:update()
    self.wx, self.wy = love.mouse.getPosition()
    self.x, self.y = display.game.coord(self.wx, self.wy)

    if mouse.instage and self.x >= config.gameWidth-1 then
        self.x = config.gameWidth-1
    end

    if mouse.instage and self.x <= 0 then
        self.x = 0    
    end

    if mouse.instage and self.y <= 0 then
        self.y = 0    
    end

    if mouse.instage and self.y > config.gameHeight-1 then
        self.y =  config.gameHeight-1   
    end


    if love.mouse.isDown(1) then
        if self.button1.newClick == false then        
            self.button1.click= true
            self.button1.newClick = true
        else
            self.button1.click= false
        end        
    else
        self.button1.newClick = false
        self.button1.click= false
    end

    if love.mouse.isDown(2) then
        if self.button2.newClick == false then        
            self.button2.click= true
            self.button2.newClick = true
        else
            self.button2.click= false
        end        
    else
        self.button2.newClick = false
        self.button2.click= false
    end    
end

function Mouse:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(images.viewFinderImg,mouse.x, mouse.y,0,1,1,images.viewFinderImg:getWidth()/2,images.viewFinderImg:getHeight()/2)
end

return class.new(Mouse)
