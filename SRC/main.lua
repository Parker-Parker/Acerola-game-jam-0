
require("test")
require("character")

-- Character.

Frames = 0
Framerate = 0
Framerate_lasttime = 0

accelMode = 0
steerMode = 0

function love.draw()
    love.graphics.print("Hello World", 400, 300)
    love.graphics.print(Looptime, 400, 400)
    love.graphics.print("Framerate: " .. Framerate, 650, 20)
    love.graphics.print("Steer:" .. steerMode.." Boost:"..accelMode, 650, 50)

    Character:draw()
    Frames = Frames + 1
end

Looptime = 0

Character:moveAbs(400,400)

function love.update(dt)
    Looptime = Looptime + dt
    -- local mousex, mousey = love.mouse.getPosition()
    -- -- Character:moveAbs(mousex, mousey)
    -- Character:moveAbsIfMin(mousex, mousey, 10)

    accelMode = (love.keyboard.isDown("w") or love.keyboard.isDown("up") ) and
                            Character.accelEnum.BOOST or Character.accelEnum.IDLE

    local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")
    local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")

    steerMode = (left == right)  and Character.steerEnum.IDLE or 
                            left and Character.steerEnum.LEFT or Character.steerEnum.RIGHT


    Character:moveRel(dt,accelMode,steerMode)


    if Looptime - Framerate_lasttime > 1 then
        Framerate = Frames/(Looptime-Framerate_lasttime)
        Framerate_lasttime = Looptime
        Frames = 0
    end
    if Looptime > 10000 then
        Looptime = 0
        Frames = 0
        Framerate_lasttime = 0
    end
end