local composer = require("composer")
local physics = require("physics")
local scene = composer.newScene()

-- Variável de pontuação
local score = 0

function scene:create(event)
    local sceneGroup = self.view

    -- Iniciar física
    physics.start()
    physics.setGravity(0, 0)

    -- Fundo
    local background = display.newImageRect(sceneGroup, "assets/images/Pag5/Pagina6.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Texto da pontuação
    local scoreText = display.newText({
        parent = sceneGroup,
        text = "Pontuação: 0",
        x = display.contentCenterX,
        y = display.contentCenterY * 1.1,
        font = native.systemFontBold,
        fontSize = 24
    })
    scoreText:setFillColor(1, 1, 1)

    -- Personagem controlável
    local player = display.newImageRect(sceneGroup, "assets/images/Pag5/player.png", 50, 50)
    player.x = display.contentCenterX
    player.y = display.contentHeight - 80
    physics.addBody(player, { radius = 25, isSensor = true })
    player.name = "player"

    -- Elementos saudáveis
    local function spawnHealthyItem()
        local item = display.newImageRect(sceneGroup, "assets/images/Pag5/SliceOfWatermelon.png", 40, 40)
        item.x = math.random(40, display.contentWidth - 40)
        item.y = -50
        physics.addBody(item, { radius = 20, isSensor = true })
        item.name = "healthy"

        -- Movimento para baixo
        transition.to(item, { y = display.contentHeight + 50, time = 4000, onComplete = function()
            display.remove(item)
        end })
    end

return scene
