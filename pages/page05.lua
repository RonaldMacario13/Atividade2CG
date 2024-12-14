local composer = require("composer")
local scene = composer.newScene()

local pageAudio

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo 
    local background = display.newImageRect(sceneGroup, "assets/images/Pag4/Pagina5.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    pageAudio = audio.loadStream("assets/audio/P4.mp3")

    -- Elementos Saudáveis e Não Saudáveis
    local dumbbell = display.newImageRect(sceneGroup, "assets/images/Pag4/Dumbbell.png", 70, 70)
    dumbbell.x = display.contentWidth * 0.3
    dumbbell.y = display.contentHeight * 0.55

    local pizza = display.newImageRect(sceneGroup, "assets/images/Pag4/Pizza.png", 70, 70)
    pizza.x = display.contentWidth * 0.7
    pizza.y = display.contentHeight * 0.55

    local watermelon = display.newImageRect(sceneGroup, "assets/images/Pag4/SliceOfWatermelon.png", 70, 70)
    watermelon.x = display.contentWidth * 0.7
    watermelon.y = display.contentHeight * 0.675

    local hamburguer = display.newImageRect(sceneGroup, "assets/images/Pag4/Hamburguer.png", 70, 70)
    hamburguer.x = display.contentWidth * 0.3
    hamburguer.y = display.contentHeight * 0.675

    local sanitizer = display.newImageRect(sceneGroup, "assets/images/Pag4/Sanitizer.png", 70, 70)
    sanitizer.x = display.contentWidth * 0.3
    sanitizer.y = display.contentHeight * 0.80

    local hotdog = display.newImageRect(sceneGroup, "assets/images/Pag4/HotDog.png", 70, 70)
    hotdog.x = display.contentWidth * 0.7
    hotdog.y = display.contentHeight * 0.80

    -- Variável de controle para permitir shake
    local canShake = true

    -- Função de Shake
    local function onShake(event)
        if event.isShake and canShake then
            canShake = false -- Desativa o shake temporariamente

            -- Energiza os elementos saudáveis
            transition.to(dumbbell, { time = 500, xScale = 1.5, yScale = 1.5, transition = easing.continuousLoop, onComplete = function()
            transition.to(dumbbell, { time = 500, xScale = 1.0, yScale = 1.0 })
            end })

            transition.to(watermelon, { time = 500, rotation = 360, transition = easing.outBounce })
            
            transition.to(sanitizer, { time = 500, xScale = 1.5, yScale = 1.5, transition = easing.continuousLoop, onComplete = function()
            transition.to(sanitizer, { time = 500, xScale = 1.0, yScale = 1.0 })
            end })


            -- Reduz os elementos não saudáveis
            transition.to(pizza, { time = 500, alpha = 0.2 })
            transition.to(hamburguer, { time = 500, alpha = 0.2 })
            transition.to(hotdog, { time = 500, alpha = 0.2 })

            -- Reativa o shake e restaura os estados originais após 5 segundos
            timer.performWithDelay(5000, function()
                canShake = true
                -- Restaura elementos saudáveis
                watermelon.rotation = 0 
                -- Restaura elementos não saudáveis
                transition.to(pizza, { time = 500, alpha = 1 })
                transition.to(hamburguer, { time = 500, alpha = 1 })
                transition.to(hotdog, { time = 500, alpha = 1 })
            end)
        end
    end

    -- Adicionar Listener para Shake
    Runtime:addEventListener("accelerometer", onShake)

    -- Botão de avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.page06", { effect = "fade" , time = 100 })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.page04")
    end)

    local home = display.newImage(
        sceneGroup,
        "assets/images/home.png"
    )
    home.x = display.contentWidth - 45
    home.y = display.contentHeight - 440 
    home:scale(0.8, 0.8)

    home:addEventListener("tap", function(event)
        print("home")
        composer.gotoScene("pages.capa")
    end)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
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
        audio.stop(1) -- Para o canal onde o áudio está tocando
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
