-- ##########################################################################
-- #                                                                        #
-- #    Projet : Missiles Encounters  -  pour la Gamecodeur Game Jam #11    #
-- #                                                                        #
-- #    Version : 1.0.5                                                     #
-- #    Auteur : Fredy Rogez (rogez.net)                                    #
-- #    Date de la première version : 23/11/2017                            #
-- #    Dernière mise à jour : 16/07/2019                                   #
-- #                                                                        #
-- #    Désolé pour la qualité du code... Je me suis laché sur le "code     #
-- #    spaghetti". Je reprendrai ça propprement... un jour, peut-être...   #
-- #                                                                        #
-- ##########################################################################


io.stdout:setvbuf('no')
--love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end 

function love.load()

    -- Configuration
    config = {}
    config.gameWidth = 1920/2
    config.gameHeight = 1080/2
    config.language = "fr" -- pas encore implémenté

    require ("modules.txt")

    display = require("modules.display")

    class = require("modules/class")
    require("modules/fonts")
    require("modules/constants")
    gfx = require("modules/gfx")
    debug = require("modules/debug")
    math2D = require("modules/math2D")       
    mobs = require("modules/mobs")
    window = require("modules/window")    
    mouse = require("modules/mouse")
    keyboard = require("modules/keyboard")
    save = require("modules/save")
    images = require("modules/images")    
    audio = require("modules/audio")        

    cities = require("modules/cities")    
    bases = require("modules/bases")        
    fx = require("modules/fx")        
    counterMissiles = require("modules/countermissiles")         
    game = require("game")   
end

function love.update(dt)       
    game:update(dt)    
end

function love.draw()
--    love.graphics.push()    
--    love.graphics.translate(window.tx, window.ty)

    display.start()
    game:draw()    
    debug:draw()
    display.stop()    
--    love.graphics.pop()
end

function love.keypressed(key)  
    keyboard:keypressed(key)
end

function love.resize(pW, pH)
    display.resize(pW, pH)
end
