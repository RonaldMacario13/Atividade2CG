local composer = require("composer")
local scene = composer.newScene()

local map -- Mapa interativo
local schoolLayer, workLayer, communityLayer -- Camadas adicionais
local finger1, finger2
local initialDistance
local isZooming = false

local pageAudio

-- Ativa multitouch
system.activate("multitouch")

local function calculateDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

local function updateLayersVisibility(scale)
    -- Exibe camadas com base no nível de zoom
    if scale > 1.5 then
        schoolLayer.isVisible = true
        workLayer.isVisible = true
        communityLayer.isVisible = true
    else
        schoolLayer.isVisible = false
        workLayer.isVisible = false
        communityLayer.isVisible = false
    end
end

local function onTouch(event)
    if event.phase == "began" then
        if not finger1 then
            finger1 = event
        elseif not finger2 then
            finger2 = event
            isZooming = true
            initialDistance = calculateDistance(finger1.x, finger1.y, finger2.x, finger2.y)
        end
    elseif event.phase == "moved" and isZooming then
        if finger1 and finger2 and event.id == finger1.id then
            finger1 = event
        elseif finger1 and finger2 and event.id == finger2.id then
            finger2 = event
        end

        if finger1 and finger2 then
            local currentDistance = calculateDistance(finger1.x, finger1.y, finger2.x, finger2.y)
            local scale = currentDistance / initialDistance
            local newScaleX = map.xScale * scale
            local newScaleY = map.yScale * scale

            -- Limita o zoom
            if newScaleX <= 3 and newScaleX >= 0.5 then
                map.xScale = newScaleX
                map.yScale = newScaleY

                -- Atualiza visibilidade das camadas
                updateLayersVisibility(map.xScale)
            end

            initialDistance = currentDistance
        end
    elseif event.phase == "ended" or event.phase == "cancelled" then
        if event.id == finger1.id then
            finger1 = nil
        elseif event.id == finger2.id then
            finger2 = nil
        end

        if not finger1 or not finger2 then
            isZooming = false
        end
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
    local background = display.newImageRect(sceneGroup, "assets/images/Pag3/Pagina4.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    pageAudio = audio.loadStream("assets/audio/P3.mp3")

    -- Mapa Interativo
    map = display.newImageRect(sceneGroup, "assets/images/Pag3/map.png", 150, 120)
    map.x = display.contentCenterX - 40
    map.y = display.contentCenterY

    -- Camadas (invisíveis inicialmente)
    schoolLayer = display.newImageRect(sceneGroup, "assets/images/Pag3/Classroom.png", 200, 150)
    schoolLayer.x = display.contentWidth * 0.3
    schoolLayer.y = display.contentHeight * 0.4
    schoolLayer.isVisible = false

    workLayer = display.newImageRect(sceneGroup, "assets/images/Pag3/Business.png", 200, 150)
    workLayer.x = display.contentWidth * 0.7
    workLayer.y = display.contentHeight * 0.6
    workLayer.isVisible = false

    communityLayer = display.newImageRect(sceneGroup, "assets/images/Pag3/Crowd.png", 200, 150)
    communityLayer.x = display.contentWidth * 0.5
    communityLayer.y = display.contentHeight * 0.5
    communityLayer.isVisible = false

    -- Botões Avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.page05", { effect = "fade", time = 100 })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.page03")
    end)

    local home = display.newImage(
        sceneGroup,
        "assets/images/home.png"
    )
    home.x = display.contentWidth - 45
    home.y = display.contentHeight - 440 
    home:scale(0.8, 0.8)

    home:addEventListener("tap", function(event)
        print("home")
        composer.gotoScene("pages.Capa")
    end)
end

function scene:show(event)
    if event.phase == "did" then
        Runtime:addEventListener("touch", onTouch)
    end

    if pageAudio then
        audio.stop(1)
        audio.seek(0, pageAudio)
        audio.play(pageAudio, { channel = 1, loops = 0 })
    end
end

function scene:hide(event)
    if event.phase == "will" then
        Runtime:removeEventListener("touch", onTouch)
        audio.stop(1)
    end
end

function scene:destroy(event)
    if pageAudio then
        audio.dispose(pageAudio)
        pageAudio = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
