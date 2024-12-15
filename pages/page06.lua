local composer = require("composer")
local physics = require("physics")
local scene = composer.newScene()

local pageAudio

local healthyItems = {
    { image = "assets/images/Pag5/SliceOfWatermelon.png", size = 40 },
    { image = "assets/images/Pag5/BittenApple.png", size = 40 },
    { image = "assets/images/Pag5/Plastic.png", size = 40 },
    { image = "assets/images/Pag5/Steak.png", size = 40 }
}

local unhealthyItems = {
    { image = "assets/images/Pag5/Hamburguer.png", size = 40 },
    { image = "assets/images/Pag5/Pizza.png", size = 40 },
    { image = "assets/images/Pag5/FrenchFries.png", size = 40 },
    { image = "assets/images/Pag5/Cola.png", size = 40 }
}

function scene:create(event)
    local sceneGroup = self.view

    -- Iniciar física
    physics.start()
    physics.setGravity(0, 0)

    -- Fundo
    local background = display.newImageRect(sceneGroup, "assets/images/Pag5/Pagina6.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    pageAudio = audio.loadStream("assets/audio/P5.mp3")

    -- Personagem controlável
    local player = display.newImageRect(sceneGroup, "assets/images/Pag5/player_happy.png", 50, 50)
    player.x = display.contentCenterX
    player.y = display.contentHeight - 80
    physics.addBody(player, { radius = 25, isSensor = true })
    player.name = "player"

    -- Elementos saudáveis
    local function spawnHealthyItem()
        -- Seleciona um item aleatório da lista saudável
        local itemData = healthyItems[math.random(#healthyItems)]
        local item = display.newImageRect(sceneGroup, itemData.image, itemData.size, itemData.size)
        item.x = math.random(40, display.contentWidth - 40)
        item.y = -50
        physics.addBody(item, { radius = itemData.size / 2, isSensor = true })
        item.name = "healthy"
    
        -- Movimento para baixo
        transition.to(item, { y = display.contentHeight + 50, time = 4000, onComplete = function()
            display.remove(item)
        end })
    end

    -- Elementos não saudáveis
    local function spawnUnhealthyItem()
        -- Seleciona um item aleatório da lista não saudável
        local itemData = unhealthyItems[math.random(#unhealthyItems)]
        local item = display.newImageRect(sceneGroup, itemData.image, itemData.size, itemData.size)
        item.x = math.random(40, display.contentWidth - 40)
        item.y = -50
        physics.addBody(item, { radius = itemData.size / 2, isSensor = true })
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
                player.fill = { type = "image", filename = "assets/images/Pag5/player_happy.png" }
                print("Item saudável coletado!")

            elseif event.object1.name == "player" and event.object2.name == "unhealthy" then
                -- Elemento não saudável atingido
                display.remove(event.object2)
                player.fill = { type = "image", filename = "assets/images/Pag5/player_sick.png" }
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
    timer.performWithDelay(2000, spawnHealthyItem, 0)
    timer.performWithDelay(2500, spawnUnhealthyItem, 0)

    -- Adicionar Listeners
    Runtime:addEventListener("collision", onCollision)
    Runtime:addEventListener("touch", movePlayer)

    -- Botão de avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.contraCapa", { effect = "fade" , time = 100 })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.page05")
    end)

    local home = display.newImage(
        sceneGroup,
        "assets/images/home.png"
    )
    home.x = display.contentWidth - 45
    home.y = display.contentHeight - 440
    home:scale(0.8, 0.8)

    home:addEventListener("tap", function(event)
        composer.gotoScene("pages.Capa")
    end)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "did") then
        if pageAudio then
            audio.stop(1)
            audio.seek(0, pageAudio)
            audio.play(pageAudio, { channel = 1, loops = 0 })
        end
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Para o áudio quando a cena estiver saindo
        audio.stop(1)
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    -- Libera o áudio para evitar vazamento de memória
    if pageAudio then
        audio.dispose(pageAudio)
        pageAudio = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
