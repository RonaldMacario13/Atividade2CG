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

end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
