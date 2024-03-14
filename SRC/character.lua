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
                        -30, 12,
                        -40, 8,
                        -30, 4,

                        -30, -4,
                        -40, -8,
                        -30, -12,

                        }
-- Character.vertTable = {  10, 0,
--                          -40, 15,
--                          -40, -15,
--                         }
                        
Character.vertTableRotated = Character.vertTable
Character.vertTableTransformed = Character.vertTableRotated


Character.x = 400
Character.y = 400
Character.theta = 0

Character.instances = {
    {Color = {   .5,    0,    0,    1}, x=400, y=400, theta = 0, bend = 1.05, vertTable=Character.vertTable },
    {Color = {  .25,  .25,    0,    1}, x=400, y=400, theta = 0, bend = 1.10, vertTable=Character.vertTable },
    {Color = {    0,   .5,    0,    1}, x=400, y=400, theta = 0, bend = 1.15, vertTable=Character.vertTable },
    {Color = {    0,  .25,  .25,    1}, x=400, y=400, theta = 0, bend = 1.20, vertTable=Character.vertTable },
    {Color = {    0,    0,   .5,    1}, x=400, y=400, theta = 0, bend = 1.25, vertTable=Character.vertTable },
    {Color = {  .25,    0,  .25,    1}, x=400, y=400, theta = 0, bend = 1.30, vertTable=Character.vertTable },



    -- {Color = {   .5,    0,    0,    1}, x=400, y=400, theta = 0, bend = 1.05, vertTable=Character.vertTable },
    -- {Color = {  .35,  .35,    0,    1}, x=400, y=400, theta = 0, bend = 1.10, vertTable=Character.vertTable },
    -- {Color = {    0,   .5,    0,    1}, x=400, y=400, theta = 0, bend = 1.15, vertTable=Character.vertTable },
    -- {Color = {    0,  .35,  .35,    1}, x=400, y=400, theta = 0, bend = 1.20, vertTable=Character.vertTable },
    -- {Color = {    0,    0,   .5,    1}, x=400, y=400, theta = 0, bend = 1.25, vertTable=Character.vertTable },
    -- {Color = {  .35,    0,  .35,    1}, x=400, y=400, theta = 0, bend = 1.30, vertTable=Character.vertTable },

}

-- Character.accelEnum = {IDLE = 0, BOOST = 1}
-- Character.steerEnum = {IDLE = 0, RIGHT = 1, LEFT = 2}
-- Character.minSpeed = 10
-- Character.maxSpeed = 800
-- Character.accelRate = 300
-- Character.decelRate = 80
-- Character.brakeRate = 30
-- Character.turnRate = 2

Character.accelEnum = {IDLE = 0, BOOST = 1}
Character.steerEnum = {IDLE = 0, RIGHT = 1, LEFT = 2}
Character.minSpeed = 150
Character.maxSpeed = 800
Character.accelRate = 600
Character.decelRate = 120
Character.brakeRate = 30
Character.turnRate = 6


Character.speed = Character.minSpeed


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
    self.vertTableRotated = {}


    local xlast = nil
    for index, value in ipairs(self.vertTable) do
        if xlast then
            local newx, newy = rotate(xlast,value,self.theta)
            self.vertTableRotated[index-1] = newx
            self.vertTableRotated[index]   = newy
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
    self.vertTableTransformed = {}


    local xlast = false
    for index, value in ipairs(self.vertTableRotated) do
        if xlast then
            self.vertTableTransformed[index] = value + self.y
            xlast = false
        else 
            self.vertTableTransformed[index] = value + self.x
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


function Character:tfSafe()
    Character.tfRot(self)
    Character.tfTra(self)
    -- self.x
end



function Character:draw()
    -- love.graphics.setColor(1,1,1,1)
    -- -- love.graphics.setColor(255,255,255)
    -- -- love.graphics.polygon(love.graphics.DrawMode.fill, self.vertTableTransformed)
    -- self:tf()
    -- love.graphics.polygon("fill", self.vertTableTransformed)
    -- -- self.x

    -----------------------------------------------------
    -- local oldX = Character.x
    -- local oldY = Character.y

    Character.y = Character.y-10
    love.graphics.setColor(1,0.5,0,1)
    self:tf()
    love.graphics.polygon("fill", self.vertTableTransformed)

    Character.y = Character.y+20
    love.graphics.setColor(0,0.5,1,1)
    self:tf()
    love.graphics.polygon("fill", self.vertTableTransformed)

    Character.y = Character.y-10

    
end

function Character:drawInstances()

    for key, instance in pairs(self.instances) do

        love.graphics.setColor(instance.Color)
        Character.tfSafe(instance)
        love.graphics.polygon("fill", instance.vertTableTransformed)
    end



    
end

function Character:drawLine()
    love.graphics.setColor(1,1,1,1)
    -- love.graphics.setColor(255,255,255)
    -- love.graphics.polygon(love.graphics.DrawMode.fill, self.vertTableTransformed)
    self:tf()
    love.graphics.polygon("line", self.vertTableTransformed)
    -- self.x
end

function Character:collisionManager(x0,y0,x1,y1)
    --store travel and collisions

end

function Character:moveRel(dt, accel, steer) 
    local cX = math.cos(self.theta)
    local cY = math.sin(self.theta)
    local newX = self.x  + dt*Character.speed*cX -- + accel_factor  -- TODO: fix dt
    local newY = self.y  + dt*Character.speed*cY -- + accel_factor  -- TODO: fix dt  

    if accel == Character.accelEnum.BOOST then
        Character.speed = Character.speed +Character.accelRate*dt -- TODO: fix dt
        if Character.speed > Character.maxSpeed then
            Character.speed = Character.maxSpeed
        end
    else
        Character.speed = Character.speed -Character.decelRate*dt -- TODO: fix dt
        if Character.speed < Character.minSpeed then
            Character.speed = Character.minSpeed
        end
    end

    if steer == Character.steerEnum.LEFT then
        self.theta = self.theta - Character.turnRate*dt -- TODO: fix dt
    elseif steer == Character.steerEnum.RIGHT then
        self.theta = self.theta + Character.turnRate*dt -- TODO: fix dt
    end

    Character:collisionManager(self.x,self.y,
                                newX,       newY)
    self.x = newX
    self.y = newY

end

function Character:moveRelInstances(dt, accel, steer) 

    for key, instance in pairs(self.instances) do
        Character.moveRel(instance, dt, accel, steer)
    end



end


function Character:testDivergeInstances() 

    for key, instance in pairs(self.instances) do
        instance.theta = instance.theta + (instance.bend-1.0)*1
    end



end
