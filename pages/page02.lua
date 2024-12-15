local composer = require("composer")
local scene = composer.newScene()

local pageAudio
local characters = {
    classroom = {},
    crowd = {},
    business = {}
}

local function animateCharacter(character)
    -- Troca o sprite para a versão feliz
    character.fill = { type = "image", filename = character.happySprite }
    -- Anima o personagem (balançar)
    transition.to(character, {
        xScale = 1.1, yScale = 1.1,
        time = 200, iterations = 5,
        onComplete = function()
            -- Retorna ao sprite triste após 5 segundos
            character.fill = { type = "image", filename = character.sadSprite }
            character.xScale = 1
            character.yScale = 1
        end
    })
end

local function toggleGroup(group)
    for _, character in ipairs(characters[group]) do
        animateCharacter(character)
    end
end

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

    pageAudio = audio.loadStream("assets/audio/P1.mp3")

    -- Adiciona personagens
    local function createCharacter(group, sadSprite, happySprite, x, y)
        local character = display.newImageRect(sceneGroup, sadSprite, 50, 50)
        character.x = x
        character.y = y
        character.sadSprite = sadSprite
        character.happySprite = happySprite
        table.insert(characters[group], character)
    end

    -- Classroom characters
    createCharacter("classroom", "assets/images/Pag1/personagens/menina.png", "assets/images/Pag1/personagens/menina-1.png", 40, 295)
    createCharacter("classroom", "assets/images/Pag1/personagens/menino2.png", "assets/images/Pag1/personagens/menino2-1.png", 90, 295)

    -- Crowd characters
    createCharacter("crowd", "assets/images/Pag1/personagens/menino-1.png", "assets/images/Pag1/personagens/menino.png", 140, 295)
    createCharacter("crowd", "assets/images/Pag1/personagens/mulher.png", "assets/images/Pag1/personagens/mulher-1.png", 190, 295)

    -- Business characters
    createCharacter("business", "assets/images/Pag1/personagens/ruivo.png", "assets/images/Pag1/personagens/ruivo-1.png", 240, 295)
    createCharacter("business", "assets/images/Pag1/personagens/mulherruiva-1.png", "assets/images/Pag1/personagens/mulherruiva.png", 290, 295)

    -- Botão de Classroom
    local btnClassroom = display.newImageRect(sceneGroup, "assets/images/Pag1/Classroom.png", 60, 60)
    btnClassroom.x = display.contentWidth / 4
    btnClassroom.y = display.contentHeight - 125
    btnClassroom:addEventListener("tap", function()
        toggleGroup("classroom")
    end)

    -- Botão de Crowd
    local btnCrowd = display.newImageRect(sceneGroup, "assets/images/Pag1/Crowd.png", 60, 60)
    btnCrowd.x = display.contentWidth / 2
    btnCrowd.y = display.contentHeight - 125
    btnCrowd:addEventListener("tap", function()
        toggleGroup("crowd")
    end)

    -- Botão de Business
    local btnBusiness = display.newImageRect(sceneGroup, "assets/images/Pag1/Business.png", 60, 60)
    btnBusiness.x = 3 * display.contentWidth / 4
    btnBusiness.y = display.contentHeight - 125
    btnBusiness:addEventListener("tap", function()
        toggleGroup("business")
    end)

    -- Botão de avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.page03", { effect = "fade", time = 100 })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.Capa")
    end)

    -- Botão Home
    local home = display.newImage(
        sceneGroup,
        "assets/images/home.png"
    )
    home.x = display.contentWidth - 45
    home.y = display.contentHeight - 440
    home:scale(0.8, 0.8)

    home:addEventListener("tap", function(event)
        composer.gotoScene("pages.Capa")
    end)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        if not _G.isMuted and pageAudio then
            audio.stop(1)
            audio.seek(0, pageAudio)
            audio.play(pageAudio, { channel = 1, loops = 0 })
        end
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        audio.stop(1)

    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

function scene:destroy(event)
    local sceneGroup = self.view
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
