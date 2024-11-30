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

    -- Sequências de imagens para as animações
    local foodFrames = {
        "assets/images/Pag2/comendo/0.png",
        "assets/images/Pag2/comendo/1.png",
        "assets/images/Pag2/comendo/2.png",
        "assets/images/Pag2/comendo/3.png",
        "assets/images/Pag2/comendo/4.png",
        "assets/images/Pag2/comendo/5.png",
        "assets/images/Pag2/comendo/6.png",
        "assets/images/Pag2/comendo/7.png"
    }

    local activityFrames = {
        "assets/images/Pag2/treino/0.png",
        "assets/images/Pag2/treino/1.png",
        "assets/images/Pag2/treino/2.png",
        "assets/images/Pag2/treino/3.png",
        "assets/images/Pag2/treino/4.png",
        "assets/images/Pag2/treino/5.png",
        "assets/images/Pag2/treino/6.png",
        "assets/images/Pag2/treino/7.png"
    }

    local awarenessFrames = {
        "assets/images/Pag2/lendo/0.png",
        "assets/images/Pag2/lendo/1.png",
        "assets/images/Pag2/lendo/2.png",
        "assets/images/Pag2/lendo/3.png",
        "assets/images/Pag2/lendo/4.png",
        "assets/images/Pag2/lendo/5.png",
        "assets/images/Pag2/lendo/6.png",
        "assets/images/Pag2/lendo/7.png"
    }

    local isFoodAnimating = false
    local isActivityAnimating = false
    local isAwarenessAnimating = false
return scene
