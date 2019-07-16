-- Gestion de le fenêtre de jeu

Window = class.set()    

function Window:init()    
    self.screenWidth, self.screenHeight = love.window.getDesktopDimensions()
    self.width = 960
    self.height = 540
    --self.scale = 1
    self.tx = 0
    self.ty = 0
    self.fullScreen = false

--   if self.fullScreen then
--        love.window.setFullscreen(true)     
--        self.width = love.graphics.getWidth()
--        self.height = love.graphics.getHeight()        
--        self.scale = self.height / config.gameHeight        
--        self.tx = (self.width-(config.gameWidth*self.scale))/2
--    end               

end

return class.new(Window)
