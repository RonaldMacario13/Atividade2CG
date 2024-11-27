local composer = require( "composer" ) --toda vez que for fazer uma capa, tem que importar
local scene = composer.newScene() --pede para o composer criar uma cena

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Adiciona o background
    local background = display.newImageRect(
        sceneGroup, 
        "assets/images/capa.jpg",  -- caminho da imagem
        display.contentWidth,  -- largura da tela
        display.contentHeight  -- altura da tela
    )
    background.x = display.contentCenterX  -- centraliza horizontalmente
    background.y = display.contentCenterY  -- centraliza verticalmente
    local btnNext = display.newImage(
        sceneGroup,
        "assets/images/BtnNext.png"
    )
    btnNext.x = display.contentWidth - 45
    btnNext.y = display.contentHeight - 40  
    btnNext:scale(0.8, 0.8)

    btnNext:addEventListener("tap", function(event)
        print("next")
        composer.gotoScene("pages.page02")
    end)
end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end

-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
