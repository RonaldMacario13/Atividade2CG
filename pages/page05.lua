local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo 
    local background = display.newImageRect(sceneGroup, "assets/images/Pag4/Pagina5.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Elementos Saudáveis e Não Saudáveis
    local dumbbell = display.newImageRect(sceneGroup, "assets/images/Pag4/Dumbbell.png", 70, 70)
    dumbbell.x = display.contentWidth * 0.3
    dumbbell.y = display.contentHeight * 0.55

    local pizza = display.newImageRect(sceneGroup, "assets/images/Pag4/Pizza.png", 70, 70)
    pizza.x = display.contentWidth * 0.7
    pizza.y = display.contentHeight * 0.55

    local watermelon = display.newImageRect(sceneGroup, "assets/images/Pag4/SliceOfWatermelon.png", 70, 70)
    watermelon.x = display.contentWidth * 0.7
    watermelon.y = display.contentHeight * 0.675

    local hamburguer = display.newImageRect(sceneGroup, "assets/images/Pag4/Hamburguer.png", 70, 70)
    hamburguer.x = display.contentWidth * 0.3
    hamburguer.y = display.contentHeight * 0.675

    local sanitizer = display.newImageRect(sceneGroup, "assets/images/Pag4/Sanitizer.png", 70, 70)
    sanitizer.x = display.contentWidth * 0.3
    sanitizer.y = display.contentHeight * 0.80

    local hotdog = display.newImageRect(sceneGroup, "assets/images/Pag4/HotDog.png", 70, 70)
    hotdog.x = display.contentWidth * 0.7
    hotdog.y = display.contentHeight * 0.80
return scene
