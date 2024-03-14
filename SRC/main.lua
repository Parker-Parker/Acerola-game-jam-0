
require("test")
require("character")

-- Character.
function love.load()
    Frames = 0
    Framerate = 0
    Framerate_lasttime = 0
    
    accelMode = 0
    steerMode = 0
    width, height = love.graphics.getDimensions( )
    
    playerCanvas = love.graphics.newCanvas(width,height)
    lensesCanvas = love.graphics.newCanvas(width,height)
    mirrorCanvas = love.graphics.newCanvas(width,height)


    Looptime = 0
    
    -- Character:moveAbs(400,400)
    
end

function drawPlayer()
    love.graphics.setCanvas(playerCanvas)
    love.graphics.clear(0, 0, 0, 0)
    -- love.graphics.setBlendMode("alpha")
    -- love.graphics.setBlendMode("add")
    love.graphics.setBlendMode("add", "premultiplied")
    -- Character:draw()
    Character:drawInstances()

end


function love.draw()
    love.graphics.setCanvas()
    love.graphics.clear(0, 0, 0, 1)
    love.graphics.setBlendMode("alpha")

    love.graphics.print("Hello World", 400, 300)
    love.graphics.print(Looptime, 400, 400)
    love.graphics.print("Framerate: " .. Framerate, 650, 20)
    love.graphics.print("Steer:" .. steerMode.." Boost:"..accelMode, 650, 50)


    -- Character:draw()
    Character:drawLine()
    drawPlayer()
    
    love.graphics.setCanvas()
    -- love.graphics.setBlendMode("alpha")
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(playerCanvas,0,0)
    
    Frames = Frames + 1
end

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
    Character:moveRelInstances(dt,accelMode,steerMode)


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


function love.keypressed( key, scancode, isrepeat )
    if (key == "space") and not isrepeat then
        Character:testDivergeInstances()
    end
    
end



