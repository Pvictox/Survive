--[[
		Arquivo inimigo.lua.
        Aqui se encontra a função de spawnar inimigos.
        Créditos ao usuário do fórum do love Pgmineno
        Link da postagem = https://love2d.org/forums/viewtopic.php?f=3&t=87710&p=230720#p230720    
  ]]--



function spanwEnemy(x,y,dt) 
    zumbi = {}   --Vetor de inimigos
       zumbi.x = x
       zumbi.y = y
       zumbi.img = imgZumbi
if (zumbi.x > hitman.x+60 or zumbi.x < hitman.x-60) and (zumbi.y > hitman.y+60 or zumbi.y<hitman.y-60) then --Acrescento inimigos no vetor
               if (quantInimigos<limite) then
                   inimigos[#inimigos+1] = zumbi
                   quantInimigos = quantInimigos+1
               end
end
   for i, inimigo in ipairs(inimigos) do --Movimento cada inimigo do vetor
        distanciaX = hitman.x-inimigo.x
        distanciaY = hitman.y - inimigo.y
        distancia = math.sqrt( distanciaX*distanciaX+distanciaY*distanciaY)
        if not parado then --auto explicativo
            velX = distanciaX/distancia*35
            velY = distanciaY / distancia*35
            inimigo.x = inimigo.x+velX*dt
            inimigo.y = inimigo.y+velY*dt
        end
        if (distanciaX==0 or distanciaY==0) then --Posição do zumbi = posição hitman
                table.remove( inimigos, i)
                quantInimigos = quantInimigos-1
        end
   end
end