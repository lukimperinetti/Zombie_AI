-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end

-- Returns the distance between two points
function math.dist(x1, y1, x2, y2) return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5 end

-- Initialize player & entities
local lstSprites = {}
local human = {}

local ZSTATE = {}
ZSTATE.NONE = ""
ZSTATE.WALK = "walk"
ZSTATE.ATTACK = "attack"
ZSTATE.BITE = "bite"
ZSTATE.CHANGEDIR = "changedir"

-- Create Zombies
function CreateZombies(pList, pType, pImageFile, pFrame)
    zombie = CreateSprite(lstSprites, 'zombie', 'monster_', 2)
    zombie.x = math.random(10, screenWidth - 10)
    zombie.y = math.random(10, (screenHeight / 2) - 10)

    zombie.speed = math.random(5, 50) / 100

    zombie.state = ZSTATE.NONE
end

function UpdateZombies(pZombie)
    if pZombie.state == ZSTATE.NONE then
        pZombie.state = ZSTATE.CHANGEDIR
    elseif pZombie.state == ZSTATE.WALK then
        local collide = false
        if pZombie.x < 0 then
            pZombie.x = 0
            collide = true
        end
        if pZombie.x > screenWidth then
            pZombie.x = screenWidth
            collide = true
        end
        if pZombie.y < 0 then
            pZombie.y = 0
            collide = true
        end
        if pZombie.y > screenHeight then
            pZombie.y = screenHeight
            collide = true
        end
        if collide then
            pZombie.state = ZSTATE.CHANGEDIR
        end
    elseif pZombie.state == ZSTATE.ATTACK then
    elseif pZombie.state == ZSTATE.CHANGEDIR then
        local angle = math.angle(pZombie.x, pZombie.y, math.random(10, screenWidth - 10),
            math.random(10, screenHeight - 10))
        pZombie.vx = pZombie.speed * 60 * math.cos(angle)
        pZombie.vy = pZombie.speed * 60 * math.sin(angle)
        pZombie.state = ZSTATE.WALK
    end
end

-- Create Sprite
function CreateSprite(pList, pType, pImageFile, pFrame)
    local mySprite = {}
    mySprite.type = pType
    mySprite.images = {}
    mySprite.currentFrame = 1

    for i = 1, pFrame do
        local fileName = "src/img/" .. pImageFile .. tostring(i) .. ".png"
        print('loading frame : ', fileName)
        mySprite.images[i] = love.graphics.newImage(fileName)
    end

    mySprite.width = mySprite.images[1]:getWidth()
    mySprite.height = mySprite.images[1]:getHeight()
    mySprite.x = 0
    mySprite.y = 0
    mySprite.vx = 0
    mySprite.vy = 0

    table.insert(pList, mySprite)
    return mySprite
end

-- Main functions
function love.load()
    screenWidth = love.graphics.getWidth() / 2
    screenHeight = love.graphics.getHeight() / 2

    human = CreateSprite(lstSprites, 'human', 'player_', 4)
    human.x = screenWidth / 2
    human.y = (screenHeight / 2) + (screenHeight / 4)

    local nZombies
    for nZombies = 1, 15 do
        CreateZombies(lstSprites, 'zombie', 'monster_', 2)
    end
end

function love.update(dt)
    for i, sprite in ipairs(lstSprites) do
        sprite.currentFrame = sprite.currentFrame + 0.1
        if sprite.currentFrame > #sprite.images + 1 then
            sprite.currentFrame = 1
        end
        sprite.x = sprite.x + sprite.vx * dt
        sprite.y = sprite.y + sprite.vy * dt

        if sprite.type == 'zombie' then
            UpdateZombies(sprite)
        end
    end

    if love.keyboard.isDown("q") then
        human.x = human.x - 1
    end
    if love.keyboard.isDown("z") then
        human.y = human.y - 1
    end
    if love.keyboard.isDown("d") then
        human.x = human.x + 1
    end
    if love.keyboard.isDown("s") then
        human.y = human.y + 1
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(2, 2)

    for i, sprite in ipairs(lstSprites) do
        local frame = sprite.images[math.floor(sprite.currentFrame)]
        love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)
    end

    love.graphics.pop()
end

function love.keypressed(key)
end

function love.mousepressed(x, y, button)
end

function love.quit()
end
