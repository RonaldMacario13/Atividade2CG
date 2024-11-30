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
        print("prev")
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
return scene
