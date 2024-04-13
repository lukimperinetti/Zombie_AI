-- Initialize player & entities
local lstSprites = {}
local human = {}

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
    local screeWidth = love.graphics.getWidth()
    local screeHeight = love.graphics.getHeight()

    human = CreateSprite(lstSprites, 'human', 'player_', 4) -- became pList, pType, pImageFile, pFrame
    human.x = screeWidth / 2
    human.y = screeHeight / 2
end

function love.update(dt)
    -- Update game logic here
end

function love.draw()
    for i, sprite in ipairs(lstSprites) do
        local frame = sprite.images[sprite.currentFrame]
        love.graphics.draw(frame, sprite.x - sprite.width / 2, sprite.y - sprite.height / 2)
    end
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
