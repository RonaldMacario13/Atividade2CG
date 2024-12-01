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

    -- Função para mostrar animação
    local function showAnimation(frames, area, type)
        -- Verifica se a animação correspondente já está em andamento
        if (type == "alimentacao" and isFoodAnimating) or
           (type == "atividade" and isActivityAnimating) or
           (type == "conscientizacao" and isAwarenessAnimating) then
            return
        end
    
        -- Define o estado da animação como ativo
        if type == "alimentacao" then
            isFoodAnimating = true
        elseif type == "atividade" then
            isActivityAnimating = true
        elseif type == "conscientizacao" then
            isAwarenessAnimating = true
        end
    
        -- Inicia a animação
        local frameIndex = 1
        local animation = display.newImageRect(sceneGroup, frames[frameIndex], 100, 100)
        animation.x = area.x
        animation.y = area.y
    
        local function nextFrame()
            frameIndex = frameIndex + 1
            if frameIndex > #frames then
                frameIndex = 1
            end
            animation.fill = { type = "image", filename = frames[frameIndex] }
        end
    
        -- Alterna quadros a cada 250ms em looping infinito
        local timerRef = timer.performWithDelay(250, nextFrame, 0)
    
        -- Função para parar a animação
        local function stopAnimation()
            timer.cancel(timerRef)
            display.remove(animation)
            animation = nil
    
            -- Atualiza o estado da animação
            if type == "alimentacao" then
                isFoodAnimating = false
            elseif type == "atividade" then
                isActivityAnimating = false
            elseif type == "conscientizacao" then
                isAwarenessAnimating = false
            end
        end
    
        -- Exemplo de interrupção automática após 10 segundos
        timer.performWithDelay(10000, stopAnimation)
    end

    -- Elementos interativos
    local objs = display.newImageRect(sceneGroup, "assets/images/Pag2/Objetos.png", 70, 70)
    objs.x = display.contentWidth * 0.5
    objs.y = display.contentHeight - 100
    objs.id = "alimentacao"

    -- Evento de arrastar
    local function onDrag(event)
        local target = event.target
        if event.phase == "began" then
            display.getCurrentStage():setFocus(target)
            target.isFocus = true
        elseif event.phase == "moved" then
            if target.isFocus then
                target.x = event.x
                target.y = event.y
            end
        elseif event.phase == "ended" or event.phase == "cancelled" then
            if target.isFocus then
                display.getCurrentStage():setFocus(nil)
                target.isFocus = false
    
                -- Detecta a área onde o elemento foi solto
                if math.abs(target.x - cafeteria.x) < 75 and math.abs(target.y - cafeteria.y) < 75 then
                    showAnimation(foodFrames, cafeteria, "alimentacao")
                elseif math.abs(target.x - gym.x) < 75 and math.abs(target.y - gym.y) < 75 then
                    showAnimation(activityFrames, gym, "atividade")
                elseif math.abs(target.x - classroom.x) < 75 and math.abs(target.y - classroom.y) < 75 then
                    showAnimation(awarenessFrames, classroom, "conscientizacao")
                end
    
                -- Retorna o elemento para sua posição original
                transition.to(target, { time = 500, x = target.initX, y = target.initY })
            end
        end
        return true
    end

    -- Adiciona evento de arrastar
    objs:addEventListener("touch", onDrag)

    -- Armazena posições iniciais dos elementos
    objs.initX = objs.x
    objs.initY = objs.y

    -- Botão de avançar
    local btnNext = display.newImage(sceneGroup, "assets/images/BtnNext.png")
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40
    btnNext:scale(0.8, 0.8)

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("pages.page04", { effect = "fade" })
    end)

    -- Botão de voltar
    local btnPrev = display.newImage(sceneGroup, "assets/images/BtnLeft.png")
    btnPrev.x = 40
    btnPrev.y = display.contentHeight - 40
    btnPrev:scale(0.8, 0.8)

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("pages.page02")
    end)

end

scene:addEventListener("create", scene)
return scene
