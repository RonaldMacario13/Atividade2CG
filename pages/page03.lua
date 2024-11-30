local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da página
    local background = display.newImageRect(sceneGroup, "assets/images/Pag2/Pagina2.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Áreas da escola
    local cafeteria = display.newImageRect(sceneGroup, "assets/images/Pag2/Tableware.png", 100, 100)
    cafeteria.x = display.contentWidth * 0.25
    cafeteria.y = display.contentHeight * 0.6

    local gym = display.newImageRect(sceneGroup, "assets/images/Pag2/Dumbbell.png", 100
, 100)
    gym.x = display.contentWidth * 0.5
    gym.y = display.contentHeight * 0.6

    local classroom = display.newImageRect(sceneGroup, "assets/images/Pag2/classroom.png", 100
, 100)
    classroom.x = display.contentWidth * 0.75
    classroom.y = display.contentHeight * 0.6
return scene
