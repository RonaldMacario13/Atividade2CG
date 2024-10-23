local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
    local sceneGroup = self.view

    local bg = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    bg:setFillColor(1, 1, 1)

    local pageText = display.newText({
        parent = sceneGroup,
        text = "Página 02",
        x = display.contentWidth - 60,
        y = 30,
        font = native.systemFontBold,
        fontSize = 24,
    })
    pageText:setFillColor(0, 0, 0)
    local btnNext = display.newImage(sceneGroup, "assets/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)


    btnNext:addEventListener("tap", function(event)
        print("next")
        composer.gotoScene("page03", { effect = "fade" })
    end)


    local btnPrev = display.newImage(sceneGroup, "Assets/BtnLeft.png")
    btnPrev.x = 40 
    btnPrev.y = display.contentHeight - 40

    btnPrev:scale(0.8, 0.8)
    btnPrev:addEventListener("tap", function(event)
        print("prev")
        composer.gotoScene("Capa")
    end)
end





scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
