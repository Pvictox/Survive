--[[
		Arquivo colisao.lua.
        Aqui se encontra as funções reponsáveis pela colisão de objetos
        Créditos ao canal Códigos Eficientes.
  ]]--

function colisao()  --Colisão do tiro com o zumbi e do zumbi com o hitman
    for i, inimigo in ipairs(inimigos) do
        if tiro.x ~= hitman.x and tiro.y ~= hitman.y then
                --Condição de colisão da bala com o zumbi
                if (Ehcolisao(inimigo.x, inimigo.y, imgZumbi:getWidth(),imgZumbi:getHeight(), tiro.x, tiro.y, projetil:getWidth(), projetil:getHeight()) ) then
                        table.remove( inimigos,i) --Inimigo morto é removido do vetor.
                        zombieDano:stop()
                        zombieDano:play()
                        quantInimigos = quantInimigos-1
                        mostraEfeito= true
                        direcao = false
                        fonteX = 1.5
                        fonteY = 1.5
                        pontX = 1.5
                        pontuacao = pontuacao+10
                        efeitoMoeda=true
                        moedaY = 1.5
                        gold = gold+3
                        if not parado then
                            carregador = carregador+0.045 --Especial é acrescentado
                        end
                        if (carregador >= 1) then --Especial tá cheio
                            carregador = 1
                            paraTempo = true
                        end 
                        if pontuacao > 100*aumento then --aumento do limite de zumbis
                            if (limite <26) then
                                limite = limite+1
                                limiteX = 1.5
                                efeitoLimite = true
                                aumento = aumento+1
                            end
                        end
                end
         end
         --Colisão do zumbi com o hitman = gameOver
        if (Ehcolisao(inimigo.x, inimigo.y, imgZumbi:getWidth(), imgZumbi:getHeight(), hitman.x-(Imghitman:getWidth()/2),hitman.y, Imghitman:getWidth(), Imghitman:getHeight())) then
                fim = true
                taVivo = false
                musicaPrincipal:stop()
        end
    end
end

--Função de colisão
function Ehcolisao(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1
end

--Colisão da bala de canhão com o zumbi
function colisaoCanhao()
if (#tirosCanhoes > 0 and #inimigos>0) then
    for i, inimigo in ipairs(inimigos) do
        for j, bala in ipairs(tirosCanhoes) do
            if (Ehcolisao(inimigo.x,inimigo.y, 25, 25, bala.x,bala.y,20,20)) then
                    table.remove( inimigos,i)
                    table.remove( tirosCanhoes,j )
                    mostraEfeito= true
                    fonteX = 1.5
                    fonteY = 1.5
                    pontX = 1.5
                    quantInimigos = quantInimigos-1
                    direcao = false
                    pontuacao = pontuacao+10
                    gold = gold+3
                    if pontuacao > 100*aumento then
                        if (limite <26) then
                            limite = limite+1
                            aumento = aumento+1
                        end
                    end
            end
        end

    end
end
end

--Colisão zumbi-Canhao
function colisaoZumbiCanhao()
    for i, inimigo in ipairs(inimigos) do
        for j, cannon in ipairs(canhoes) do
            if (Ehcolisao(inimigo.x, inimigo.y, 25,25, cannon.x,cannon.y, Imgcanhao:getWidth()+10,Imgcanhao:getHeight()+10)) then
                table.remove( inimigos,i )
                quantInimigos = quantInimigos-1
            end
        end
    end
end