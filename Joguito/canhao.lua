function addCanhoes()
    if (quantCanhoes == 0 and love.keyboard.isDown('x') and gold>=20) then
            canhoes[#canhoes+1] = canhao1
            quantCanhoes = quantCanhoes+1
            gold = gold-20
            custoCanhao = 70
    end
    if (quantCanhoes == 1 and love.keyboard.isDown('x') and gold>=70) then
        canhoes[#canhoes+1] = canhao2
        quantCanhoes = quantCanhoes+1
        gold = gold-70
        custoCanhao = 120
    end
    if (quantCanhoes == 2 and  love.keyboard.isDown('x') and gold>=120) then
        canhoes[#canhoes+1] = canhao3
        quantCanhoes = quantCanhoes+1
        gold = gold-120
        custoCanhao = 160
    end
    if (quantCanhoes == 3 and  love.keyboard.isDown('x') and gold>=160) then
        canhoes[#canhoes+1] = canhao4
        quantCanhoes = quantCanhoes+1
        gold = gold-160
    end
    if (quantCanhoes == 4 ) then
        custoCanhao = "Vendidos"
    end
end

function atiraCanhao (dt)
    if not parado then
        tempoTiro = tempoTiro-(1*dt)
        if (tempoTiro<0) then
            if quantCanhoes > 0 then
                soundCannon:play()
            end
            for i, cannon in ipairs(canhoes) do
                bala = {
                    x = cannon.x,
                    y = cannon.y,
                    id = cannon.id
                }
                tirosCanhoes[#tirosCanhoes+1] = bala
                tempoTiro = 11
            end
        end

        for i, bala in ipairs(tirosCanhoes) do
            if (bala.id == 1) then
                    bala.x = bala.x + (50*dt)
                    bala.y = bala.y + (50*dt)
            end
            if (bala.id == 2 ) then
                bala.x = bala.x - (50*dt)
                bala.y = bala.y - (50*dt)
            end
            if (bala.id == 3) then
                bala.x = bala.x - (50*dt)
                bala.y = bala.y + (50*dt)
            end
            if (bala.id == 4) then
                bala.x = bala.x + (50*dt)
                bala.y = bala.y - (50*dt)
            end
            if (bala.y <0 or bala.y>alturaTela or bala.x > larguraTela or bala.x <0) then
                table.remove( tirosCanhoes, i )
            end
        end
    end
end