local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Adiciona o background
    local background = display.newImageRect(
        sceneGroup,
        "assets/images/Pag1/Pagina2.png",
        display.contentWidth,
        display.contentHeight
    )

    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Cria o overlay semitransparente
    local overlay = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    overlay:setFillColor(0, 0, 0, 0.5) -- Cor preta com 50% de opacidade
    overlay.isVisible = false
    overlay.isHitTestable = true

    -- Declara as imagens como variáveis globais ao escopo da função `scene:create`
    local image1, image2, image3

    -- Função para mostrar/ocultar imagens associadas aos botões
    local function toggleImage(image)
        -- Fecha todas as imagens abertas antes de abrir a nova
        overlay.isVisible = true
        if image1 then image1.isVisible = false end
        if image2 then image2.isVisible = false end
        if image3 then image3.isVisible = false end

        -- Mostra a nova imagem
        image.isVisible = true
        overlay:toFront() -- Move o overlay para o topo
        image:toFront() -- Garante que a imagem fique acima do overlay
    end

    -- Função para fechar qualquer imagem aberta
    local function closeImage()
        overlay.isVisible = false
        if image1 then image1.isVisible = false end
        if image2 then image2.isVisible = false end
        if image3 then image3.isVisible = false end
    end

    -- Botão 1
    local btn1 = display.newImageRect(sceneGroup, "assets/images/Pag1/Classroom.png", 60, 60)
    btn1.x = display.contentWidth / 4
    btn1.y = display.contentHeight - 125

    image1 = display.newImageRect(sceneGroup, "assets/images/Pag1/Frame1.png", 300, 300)
    image1.x = display.contentCenterX
    image1.y = display.contentCenterY
    image1.isVisible = false

    btn1:addEventListener("tap", function()
        toggleImage(image1)
    end)

    -- Botão 2
    local btn2 = display.newImageRect(sceneGroup, "assets/images/Pag1/Crowd.png", 60, 60)
    btn2.x = display.contentWidth / 2
    btn2.y = display.contentHeight - 125

    image2 = display.newImageRect(sceneGroup, "assets/images/Pag1/Frame2.png", 300, 300)
    image2.x = display.contentCenterX
    image2.y = display.contentCenterY
    image2.isVisible = false

    btn2:addEventListener("tap", function()
        toggleImage(image2)
    end)

    -- Botão 3
    local btn3 = display.newImageRect(sceneGroup, "assets/images/Pag1/Business.png", 60, 60)
    btn3.x = 3 * display.contentWidth / 4
    btn3.y = display.contentHeight - 125

    image3 = display.newImageRect(sceneGroup, "assets/images/Pag1/Frame3.png", 300, 300)
    image3.x = display.contentCenterX
    image3.y = display.contentCenterY
    image3.isVisible = false

    btn3:addEventListener("tap", function()
        toggleImage(image3)
    end)

    -- Adiciona o evento de toque no overlay para fechar a imagem
    overlay:addEventListener("tap", closeImage)

    -- Botão de avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.page03", { effect = "fade" })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.Capa")
    end)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen

    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

function scene:destroy(event)
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
