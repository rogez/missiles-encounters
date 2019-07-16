-- pas encore implémenté...

local FR = {}
local EN = {}

FR.score = "SCORE"
EN.score = "SCORE"

FR.newGame = "NOUVELLE PARTIE"
EN.newGame = "NEW GAME"

function setLang(pLang)
    if pLang == "fr" then
        TXT = FR
    elseif pLang == "en" then
        TXT = EN
    else
        TXT = EN
    end
end
