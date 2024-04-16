-- Initialize player & entities
local lstSprites = {}
local human = {}

function CreateZombies(pList, pType, pImageFile, pFrame) -- pList: find in lstSprites, pType: wich type? Zombie, human..., pImageFile: name of the file, pFrame: number of frames (player move etc..), pNumber: number of zombies

end

-- Sprite generation for Zombie & Human
function CreateSprite(pList, pType, pImageFile, pFrame) -- pList: find in lstSprites, pType: wich type? Zombie, human..., pImageFile: name of the file, pFrame: number of frames (player move etc..)
    local mySprite = {}
    mySprite.type = pType
    mySprite.images = {}      -- store my entity frames
    mySprite.currentFrame = 1 -- choose the first frame (image) as defaults

    for i = 1, pFrame do
        local fileName = "src/img/" .. pImageFile .. tostring(i) .. ".png"
        print('loading frame : ', fileName)
        mySprite.images[i] = love.graphics.newImage(fileName)
    end

    mySprite.x = 0
    mySprite.y = 0
    mySprite.width = mySprite.images[1]:getWidth()
    mySprite.height = mySprite.images[1]:getHeight()

    table.insert(pList, mySprite)
    return mySprite
end

function love.load()
    -- Initialize game resources and variables here
    local screeWidth = love.graphics.getWidth() / 2
    local screeHeight = love.graphics.getHeight() / 2

    human = CreateSprite(lstSprites, 'human', 'player_', 4) -- became pList, pType, pImageFile, pFrame
    human.x = screeWidth / 2
    human.y = (screeHeight / 2) + (screeHeight / 4)

    local nZombies
    for nZombies = 1, 10 do
        local zombie = CreateSprite(lstSprites, 'zombie', 'monster_', 2) -- became pList, pType, pImageFile, pFrame, pNumber
        zombie.x = math.random(10, screeWidth - 10)
        zombie.y = math.random(10, (screeHeight / 2) - 10)
    end
end

function love.update(dt)
    -- Update game logic here

    for i, sprite in ipairs(lstSprites) do
        sprite.currentFrame = sprite.currentFrame + 0.1
        if sprite.currentFrame > #sprite.images + 1 then
            sprite.currentFrame = 1
        end
    end

    if love.keyboard.isDown("q") then -- go left
        human.x = human.x - 1
    end
    if love.keyboard.isDown("z") then -- go up
        human.y = human.y - 1
    end
    if love.keyboard.isDown("d") then -- go right
        human.x = human.x + 1
    end
    if love.keyboard.isDown("s") then -- go down
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
    -- Handle key presses here
end

function love.mousepressed(x, y, button)
    -- Handle mouse presses here
end

function love.quit()
    -- Clean up resources and save data here
end
