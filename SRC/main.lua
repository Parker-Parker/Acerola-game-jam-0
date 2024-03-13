
require("test")
require("character")

-- Character.

frames = 0
framerate = 0
framerate_lasttime = 0
function love.draw()
    love.graphics.print("Hello World", 400, 300)
    love.graphics.print(looptime, 400, 400)
    love.graphics.print("Framerate: " .. framerate, 650, 20)

    Character:draw()
    frames = frames + 1
end

looptime = 0

function love.update(dt) 
    looptime = looptime + dt
    local mousex, mousey = love.mouse.getPosition()
    -- Character:moveAbs(mousex, mousey)
    Character:moveAbsIfMin(mousex, mousey, 10)


    
    if looptime - framerate_lasttime > 1 then
        framerate = frames/(looptime-framerate_lasttime)
        framerate_lasttime = looptime
        frames = 0
    end
    if looptime > 10000 then
        looptime = 0
        frames = 0
        framerate_lasttime = 0
    end
end