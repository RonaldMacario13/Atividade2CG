local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
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

    -- Função para mostrar/ocultar imagens associadas aos botões
    local function toggleImage(image)
        if image.isVisible then
            image.isVisible = false
            image:scale(0.1, 0.1)
        else
            image.isVisible = true
            image:scale(10, 10)
        end
    end

    -- Botão 1
    local btn1 = display.newImageRect(sceneGroup, "assets/images/Pag1/Classroom.png", 60, 60)
    btn1.x = display.contentWidth / 4
    btn1.y = display.contentHeight - 125

    local image1 = display.newImageRect(sceneGroup, "assets/images/Pag1/Frame1.png", 10 , 10)
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

    local image2 = display.newImageRect(sceneGroup, "assets/images/Pag1/Frame2.png", 10, 10)
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

    local image3 = display.newImageRect(sceneGroup, "assets/images/Pag1/Frame3.png", 10, 10)
    image3.x = display.contentCenterX
    image3.y = display.contentCenterY
    image3.isVisible = false

    btn3:addEventListener("tap", function()
        toggleImage(image3)
    end)

    -- Botão de avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)


    btnNext:addEventListener("tap", function(event)
        print("next")
        composer.gotoScene("pages.page03", { effect = "fade" })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40 
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        print("prev")
        composer.gotoScene("pages.Capa")
    end)
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
