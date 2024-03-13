print("Hello Character module")
Character = {}
-- Character.r = {}
-- Character.o = {}
-- Character.y = {}
-- Character.g = {}
-- Character.b = {}
-- Character.i = {}
-- Character.v = {}
Character.vertTable = {  10, 0,
                         -40, 15,
                         -40, -15,
                        }
                        
Character.vertTableRotated = Character.vertTable
Character.vertTableTransformed = Character.vertTableRotated


Character.x = 0
Character.y = 0
Character.theta = 0

function Character:moveAbs(newX, newY)
    self.theta = math.atan2(newY-self.y,newX-self.x)
    self.x = newX
    self.y = newY
end

function Character:moveAbsIfMin(newX, newY, minimum)
    if math.abs(self.x-newX)+math.abs(self.y-newY) > minimum then
        self:moveAbs(newX,newY)
    end
end

function rotate(x,y,angle)
    local rotatedx = (x)*math.cos(angle) - y*math.sin(angle);
    local rotatedy = (x)*math.sin(angle) + y*math.cos(angle);
    return rotatedx, rotatedy
end

function Character:tfRot()
    -- clear vertTableRotated
    -- for k,v in pairs(Character.vertTableRotated) do
    --     Character.vertTableRotated[k] = nil
    -- end 
    -- for key, value in pairs(Character.vertTableRotated) do
    --     print("TFrot key:" , key , " val:" , value)
    -- end
    Character.vertTableRotated = {}


    local xlast = nil
    for index, value in ipairs(Character.vertTable) do
        if xlast then
            local newx, newy = rotate(xlast,value,Character.theta)
            Character.vertTableRotated[index-1] = newx
            Character.vertTableRotated[index]   = newy
            xlast = nil
        else 
            xlast = value
        end 
        
    end
    -- Character.vertTable
    -- self.theta
    -- self.x
end

function Character:tfTra()
    Character.vertTableTransformed = {}


    local xlast = false
    for index, value in ipairs(Character.vertTableRotated) do
        if xlast then
            Character.vertTableTransformed[index] = value + Character.y
            xlast = false
        else 
            Character.vertTableTransformed[index] = value + Character.x
            xlast = true
        end 
        
    end
    -- Character.vertTable
    -- self.theta
    -- self.x
end

function Character:tf()
    self:tfRot()
    self:tfTra()
    -- self.x
end


function Character:draw()
    love.graphics.setColor(1,1,1)
    -- love.graphics.setColor(255,255,255)
    -- love.graphics.polygon(love.graphics.DrawMode.fill, self.vertTableTransformed)
    self:tf()
    love.graphics.polygon("fill", self.vertTableTransformed)
    -- self.x
end
