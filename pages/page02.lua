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

    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)


    btnNext:addEventListener("tap", function(event)
        print("next")
        composer.gotoScene("pages.page03", { effect = "fade" })
    end)


    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40 
    btnPrev.y = display.contentHeight - 40

    btnPrev:scale(0.8, 0.8)
    btnPrev:addEventListener("tap", function(event)
        print("prev")
        composer.gotoScene("pages.Capa")
    end)
end





scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
