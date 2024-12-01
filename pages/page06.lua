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

    -- Elementos não saudáveis
    local function spawnUnhealthyItem()
        local item = display.newImageRect(sceneGroup, "assets/images/Pag5/Hamburguer.png", 40, 40)
        item.x = math.random(40, display.contentWidth - 40)
        item.y = -50
        physics.addBody(item, { radius = 20, isSensor = true })
        item.name = "unhealthy"

        -- Movimento para baixo
        transition.to(item, { y = display.contentHeight + 50, time = 4000, onComplete = function()
            display.remove(item)
        end })
    end

    -- Colisão
    local function onCollision(event)
        if event.phase == "began" then
            if event.object1.name == "player" and event.object2.name == "healthy" then
                -- Elemento saudável coletado
                display.remove(event.object2)
                score = score + 10 
                scoreText.text = "Pontuação: " .. score 
                print("Item saudável coletado!")

            elseif event.object1.name == "player" and event.object2.name == "unhealthy" then
                -- Elemento não saudável atingido
                display.remove(event.object2)
                score = score - 5 -- Penalidade na pontuação
                scoreText.text = "Pontuação: " .. score 
                print("Evite itens não saudáveis!")
            end
        end
    end

    -- Movimentação do jogador
    local function movePlayer(event)
        local phase = event.phase
        if phase == "began" or phase == "moved" then
            player.x = event.x
        end
    end

    -- Spawn periódico de itens
    timer.performWithDelay(1000, spawnHealthyItem, 0)
    timer.performWithDelay(1500, spawnUnhealthyItem, 0) 

    -- Adicionar Listeners
    Runtime:addEventListener("collision", onCollision)
    Runtime:addEventListener("touch", movePlayer)

        -- Botão de avançar
        local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
        btnNext.x = display.contentWidth - 45
        btnNext.y = display.contentHeight - 40
        btnNext:scale(0.8, 0.8)
    
        btnNext:addEventListener("tap", function(event)
            composer.gotoScene("pages.contraCapa", { effect = "fade" })
        end)
    
        -- Botão de voltar
        local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
        btnPrev.x = 40
        btnPrev.y = display.contentHeight - 40
        btnPrev:scale(0.8, 0.8)
    
        btnPrev:addEventListener("tap", function(event)
            composer.gotoScene("pages.page05")
        end)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
