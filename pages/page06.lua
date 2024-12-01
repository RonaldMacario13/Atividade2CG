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
        parent = sceneGroup,
        text = "Página 05",
        x = display.contentWidth - 60,
        y = 30,
        font = native.systemFontBold,
        fontSize = 24,
    })
    pageText:setFillColor(0, 0, 0)
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40 
    btnNext:scale(0.8, 0.8)


    btnNext:addEventListener("tap", function(event)
        print("next")
        composer.gotoScene("pages.contraCapa", { effect = "fade" })
    end)


    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40  
    btnPrev.y = display.contentHeight - 40 

    btnPrev:scale(0.8, 0.8)
    btnPrev:addEventListener("tap", function(event)
        print("prev")
        composer.gotoScene("pages.page04")
    end)
end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
