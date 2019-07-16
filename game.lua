Game = class.set()

function Game:init()

    self.scenes = {} 
    self.scenes.start = require("scenes/start")
    self.scenes.mainMenu = require("scenes/mainmenu")
    self.scenes.stages = require("scenes/stages")        
    self.scenes.pause = require("scenes/pause")    
    self.scenes.gameOver = require("scenes/gameover")        
    love.mouse.setVisible(false)

    love.math.setRandomSeed(love.timer.getTime())

    self.bestScore = 0
    self.bestLevel = 0
    self.state = START_LOAD    

    self.min_dt = 1/60 -- Limite à 60 FPS
    self.next_time = love.timer.getTime()
end    

function Game:update(dt)        

    self.next_time = self.next_time + self.min_dt
    mouse:update()

    if self.state == START_LOAD then
        self.scenes.start:load()
        self.state = START

    elseif self.state == START then
        self.scenes.start:update()

    elseif self.state == MAIN_MENU_LOAD then
        self.scenes.mainMenu:load()
        self.state = MAIN_MENU       
        mouse.instage = false

    elseif self.state == MAIN_MENU then
        self.scenes.mainMenu:update()           

    elseif self.state == STAGE_LOAD then
        self.scenes.stages:load()
        self.state = STAGE
        mouse.instage = true
    elseif self.state == STAGE then
        self.scenes.stages:update()

    elseif self.state == PAUSE_LOAD then
        self.scenes.pause:load()
        self.state = PAUSE
        mouse.instage = false

    elseif self.state == PAUSE then
        self.scenes.pause:update()

    elseif self.state == GAME_OVER_LOAD then
        mouse.instage = false
        self.scenes.gameOver:load()
        self.state = GAME_OVER

    elseif self.state == GAME_OVER then
        self.scenes.gameOver:update()

    else self.state = MAIN_MENU_LOAD
    end    
end

function Game:draw()

    if self.state == START then
        self.scenes.start:draw()       

    elseif self.state == MAIN_MENU then
        self.scenes.mainMenu:draw()       

    elseif self.state == STAGE then
        self.scenes.stages:draw()            

    elseif self.state == PAUSE then
        self.scenes.pause:draw()            

    elseif self.state == GAME_OVER then
        self.scenes.gameOver:draw()
    end

    local cur_time = love.timer.getTime()    
    if self.next_time <= cur_time then
        self.next_time = cur_time
        return
    end   
    self.sleepTime = self.next_time - cur_time
    love.timer.sleep(self.sleepTime)

end

return class.new(Game)
