Save = class.set()

function Save:init()
    self.filename = "record.sav"
end

function Save:write(pScore, pLevel)
    local file = love.filesystem.newFile(self.filename)
    file:open("w")
    file:write(tostring(pScore).."\n")
    file:write(tostring(pLevel).."\n")
    file:close()        
end        

function Save:read()   
    local record = {}        

    if love.filesystem.getInfo(self.filename, nil) then        
        for line in love.filesystem.lines(self.filename) do
            table.insert(record, line)
        end
    else
        table.insert(record, "0")
        table.insert(record, "0")
    end            
    return tonumber(record[1]), tonumber(record[2])                        
end

return class.new(Save)
