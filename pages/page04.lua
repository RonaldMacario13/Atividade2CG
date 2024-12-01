local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo branco
    local background = display.newImageRect(sceneGroup, "assets/images/Pag3/Pagina4.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Botão Próxima Página
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.page05", { effect = "fade" })
    end)

    -- Botão Página Anterior
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.page03")
    end)

    -- Mapa Interativo
    local map = display.newImageRect(sceneGroup, "assets/images/Pag3/map.png", 150, 120)
    map.x = display.contentCenterX
    map.y = display.contentCenterY * 1.5

    -- Camadas Adicionais (Invisíveis no Início)
    local schoolLayer = display.newImageRect(sceneGroup, "assets/images/Pag3/Classroom.png", 200, 150)
    schoolLayer.x = display.contentWidth * 0.3
    schoolLayer.y = display.contentHeight * 0.4
    schoolLayer.isVisible = false

    local communityLayer = display.newImageRect(sceneGroup, "assets/images/Pag3/Crowd.png", 200, 150)
    communityLayer.x = display.contentWidth * 0.5
    communityLayer.y = display.contentHeight * 0.5
    communityLayer.isVisible = false

    local workLayer = display.newImageRect(sceneGroup, "assets/images/Pag3/Business.png", 200, 150)
    workLayer.x = display.contentWidth * 0.7
    workLayer.y = display.contentHeight * 0.6
    workLayer.isVisible = false

    -- Detectar Gesto de Pinça com Multitouch
    local function onPinch(event)
        if event.phase == "began" then
            if event.numTouches == 2 then
                -- Armazena a distância inicial entre os dois dedos
                map.startDistance = math.sqrt((event.x - event.xStart) ^ 2 + (event.y - event.yStart) ^ 2)
                map.startScale = map.xScale
            end
        elseif event.phase == "moved" and event.numTouches == 2 then
            -- Calcula a nova distância entre os dedos
            local newDistance = math.sqrt((event.x - event.xStart) ^ 2 + (event.y - event.yStart) ^ 2)
            local scale = newDistance / map.startDistance

            -- Atualiza o zoom no mapa
            map.xScale = map.startScale * scale
            map.yScale = map.startScale * scale

            -- Revela camadas com base no nível de zoom
            if map.xScale > 1.5 then
                schoolLayer.isVisible = true
                communityLayer.isVisible = true
                workLayer.isVisible = true
            else
                schoolLayer.isVisible = false
                communityLayer.isVisible = false
                workLayer.isVisible = false
            end
        elseif event.phase == "ended" or event.phase == "cancelled" then
            -- Reseta a escala inicial quando o gesto termina
            map.startDistance = nil
            map.startScale = nil
        end
        return true
    end

    -- Ativar Multitouch
    system.activate("multitouch")
    map:addEventListener("touch", onPinch)

        -- Botão de avançar
        local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
        btnNext.x = display.contentWidth - 45
        btnNext.y = display.contentHeight - 40
        btnNext:scale(0.8, 0.8)
    
        btnNext:addEventListener("tap", function(event)
            composer.gotoScene("pages.page05", { effect = "fade" })
        end)
    
        -- Botão de voltar
        local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
        btnPrev.x = 40
        btnPrev.y = display.contentHeight - 40
        btnPrev:scale(0.8, 0.8)
    
        btnPrev:addEventListener("tap", function(event)
            composer.gotoScene("pages.page03")
        end)

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
