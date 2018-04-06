function get_cube(cube_x, cube_y, size)
  return {x, y, x, y + size, x + size, y + size, x + size, y}
end

function switch(t)
  t.case = function (self,x)
    local f=self[x] or self.default
    if f then
      if type(f)=="function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end

function love.draw()
  love.graphics.draw(player, x, y, rotate, scale, scale, player:getWidth()/2, player:getHeight()/2)
end

function love.focus(f)
  gameIsPaused = not f
end

function love.load()
  player = love.graphics.newImage("ship.png")
  world = love.physics.newWorld(0, 200, true)
  x = 400
  y = 300
  yspeed = 0
  xspeed = 0
  rotate = 0
  rspeed = 0
  scale = 1
  accel = 100 * scale
  degree = math.pi

  static = {}
    static.b = love.physics.newBody(world, 400,400, "static") -- "static" makes it not move
    static.s = love.physics.newRectangleShape(200,50)         -- set size to 200,50 (x,y)
    static.f = love.physics.newFixture(static.b, static.s)
    static.f:setUserData("Block")

end

function love.keypressed(key)
  action = switch {
    ["up"] = function () yspeed = yspeed - accel end,
    ["down"] = function () yspeed = yspeed + accel end,
    ["left"] = function () xspeed = xspeed - accel end,
    ["right"] = function () xspeed = xspeed + accel end,
    ["q"] = function () rspeed = rspeed - degree end,
    ["e"] = function () rspeed = rspeed + degree end,
    default = function () end
  }
  action:case(key)
end

function love.keyreleased(key)
  action = switch {
    ["up"] = function () yspeed = yspeed + accel end,
    ["down"] = function () yspeed = yspeed - accel end,
    ["left"] = function () xspeed = xspeed + accel end,
    ["right"] = function () xspeed = xspeed - accel end,
    ["q"] = function () rspeed = rspeed + degree end,
    ["e"] = function () rspeed = rspeed - degree end,
    default = function () end
  }
  action:case(key)
end

function can_move(pos, size, boundry)
  return not (pos + size > boundry and pos + size < 0)
end

function love.update(dt)
	if gameIsPaused then return end
  world:update(dt)

  new_x = x + xspeed * dt
  new_y = y + yspeed * dt
  rotate = rotate + rspeed * dt
  if can_move(new_x, player:getWidth(), love.graphics.getWidth()) then x = new_x end
  if can_move(new_y, player:getHeight(), love.graphics.getHeight()) then y = new_y end
end

function love.quit()
  print("Thanks for playing! Come back soon!")
end

-- Book: http://sheepolution.com/learn/book/contents
-- LOVE API: http://nova-fusion.com/2011/06/14/a-guide-to-getting-started-with-love2d/

-- Find your way: https://love2d.org/wiki/Category:Tutorials
-- Main Tutorial: https://love2d.org/wiki/Tutorial:Callback_Functions

--https://github.com/atom/teletype/issues/211
--https://love2d.org/wiki/Getting_Started
