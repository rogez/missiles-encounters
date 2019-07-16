local class = {}
local cm = {} -- metas
local cr = {} -- reverses

-- Définition d'une classe
function class.set()
    local class = {}
    local mt = { __index = class }
    cm[class] = mt
    cr[mt] = class
    return class
end

-- Création d'une instance
function class.new(p, ...)
    local c =  setmetatable({}, cm[p])    
    c:init(...) -- Constructeur    
    return c
end

-- Création d'une sous-classe
function class.sub(p)    
    return setmetatable(class.set(), cm[p])
end

return class
