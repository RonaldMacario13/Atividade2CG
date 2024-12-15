local composer = require( "composer" )
 
composer.gotoScene("pages.Capa")

-- Variável global para controlar o estado do som
_G.isMuted = false

-- Função para criar o botão de Mute
local function createMuteButton()
    -- Cria o botão de Mute como uma imagem
    local muteButton = display.newImageRect(
        "assets/images/SoundOn.png",
        60,
        60
    )
    muteButton.x = display.contentWidth - 280
    muteButton.y = 40

    -- Função para alternar o estado do som
    local function toggleMute()
        if _G.isMuted then
            _G.isMuted = false
            muteButton.fill = { type = "image", filename = "assets/images/SoundOn.png" }
            audio.setVolume(1) 
        else
            _G.isMuted = true
            muteButton.fill = { type = "image", filename = "assets/images/SoundOff.png" }
            audio.setVolume(0) 
        end
    end

    -- Adiciona o evento de toque ao botão
    muteButton:addEventListener("tap", toggleMute)

    -- Retorna o botão para ser usado nas cenas
    return muteButton
end

-- Adiciona o botão Mute à interface global
local muteButton = createMuteButton()
muteButton:toFront()