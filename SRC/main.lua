
require("test")
looptime = 0
function love.draw()
    love.graphics.print("Hello World", 400, 300)
    love.graphics.print(looptime, 400, 400)
end
function love.update(dt) 
    looptime = looptime + dt

end