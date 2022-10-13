--  Seção de Agradecimentos
--[[Thriller 8 bits - https://www.youtube.com/watch?v=VQWeJYI033Q
Zumbi - https://www.youtube.com/watch?v=2S-wuQ5p_RM
Risada - https://www.youtube.com/watch?v=1iHkqgKMBDc
Tique - https://www.youtube.com/watch?v=8VUgLhAvN0U
Bot�o Start - http://pixelartmaker.com/art/35e5a93c4db634d
Bot�o Quit - http://pixelartmaker.com/art/4ff78990f71467a
Ajuda com click do mouse - Usu�rio OdnRVNS--]]

-- Seção de Agradecimentos

--[[
		Arquivo main.lua.
		Aqui se encontra as funções principais do love (draw,update e load) além de outras funções importates.
  ]]--

larguraTela = love.graphics.getWidth() --800
alturaTela = love.graphics.getHeight() --600

-- Flag tela de inicio
telaStart = true

	function love.load()
		love.window.setTitle("SURVIVE-IF YOU CAN")
		--Seção de carregamento de imagens
		imagemMoeda = love.graphics.newImage("Imagens/moeda.png")
		Imghitman = love.graphics.newImage("Imagens/PNG/Hitman 1/hitman1_gun.png")
		projetil = love.graphics.newImage("Imagens/PNG/tiro.png")
		Imgcanhao = love.graphics.newImage("Imagens/canhao.png")
		ImgTiroCanhao = love.graphics.newImage("Imagens/ball.png")
		zumbiFace = love.graphics.newImage("Imagens/zumbiFace.png")
		background = love.graphics.newImage("Imagens/PNG/Tiles/tile_01.png")
		imgZumbi = love.graphics.newImage("Imagens/PNG/Zombie 1/zoimbie1_hold.png")
		imgMiniCanhao = love.graphics.newImage("Imagens/miniCanhao2.png")
		imgGameOver =love.graphics.newImage("Imagens/gameOver.jpg")
		barraVazia = love.graphics.newImage("Imagens/tempo/barravazia.png")
		barraCheia = love.graphics.newImage("Imagens/tempo/barracheia.png")
		aviso = love.graphics.newImage("Imagens/tempo/aviso.png")
		telaInicio = love.graphics.newImage("Imagens/TelaInicio.png")
		botaoStart = love.graphics.newImage("Imagens/botaoStart.png")
		botaoQuit = love.graphics.newImage("Imagens/botaoQuit.png")
		-- Fim seção imagens
		--Seção Sons
		musicaPrincipal = love.audio.newSource("som/musica.mp3","static")
		somTiro = love.audio.newSource("som/tiro.mp3","static")
		risadaGameOver = love.audio.newSource("som/risada.mp3", "static")
		zombieDano = love.audio.newSource("som/zombieDamage.mp3","static")
		zaWarudo = love.audio.newSource("som/zawarudo.mp3", "static")
		tique = love.audio.newSource("som/tique.mp3", "static")
		voltaNormal = love.audio.newSource("som/volta.mp3", "static")
		soundCannon = love.audio.newSource("som/canhao.mp3", "static")
		musicaMenu = love.audio.newSource("som/menu.mp3", "static")
		-- Fim seção sons
		--Chamada arquivos necessários
		require "inimigo"
		require "colisao"
		require "canhao"
		math.randomseed(os.time())
		--Inicialização de variávies
		inimigos = {}
		canhoes = {}
		tirosCanhoes = {}
		quantInimigos = 0
		limite = 5
		aumento = 1
		love.mouse.setVisible(true)
		hitman = {    
			x = larguraTela/2,
			y = alturaTela/2
		}
		canhao1 = {
			x = 60,
			y = 80,
			angulo = -1*math.atan2(larguraTela/2-120,alturaTela/2-120),
			id = 1
		}
		canhao2 = {
			x = larguraTela-70,
			y = alturaTela-50,
			angulo = 2.5*math.atan2(larguraTela/2,alturaTela/2),
			id = 2

		}
		canhao3 ={
			x = 750,
			y = 90,
			angulo = math.atan2(larguraTela/2,alturaTela/2),
			id =3
		}
		canhao4 = {
			x = 50,
			y = alturaTela-55,
			angulo = -1*math.atan2(larguraTela,alturaTela)-20,
			id=4
		}
		tiro = {
			x = hitman.x,
			y = hitman.y,
			posX = 0,
			posY = 0,
			rotProjetil = 0
		}
		direcao = false
		mantemDirecao = true
		pontuacao = 0
		gold = 0
		quantCanhoes = 0
		tempoTiro = 11
		custoCanhao = 20
		fonteX = 1
		fonteY = 1
		pontX = 1
		limiteX = 1
		moedaY = 1
		tempoEfeitoX = 2
		tempoEfeitoY = 2
		mostraEfeito = false
		efeitoLimite = false
		efeitoMoeda = false
		taVivo = true
		--pause
		pause = false
		fonte = love.graphics.newImageFont("Imagens/fonte.png", " abcdefghijklmnopqrstuvwxyz".."ABCDEFGHIJKLMNOPQRSTUVWXYZ0".."123456789.,!?-+/():;%&`'*#=[]\"",0.5)
		fim = false
		paraTempo = false
		carregador = 0
		animAviso = 0.5
		parado = false
		timeStop = 0
	end

	function love.update(dt)
		if not pause  then -- Jogo não está pausado 
			movimentoMouse()
			if direcao and mantemDirecao then --Movimentação da bala.
				somTiro:stop()
				somTiro:play()
				tiro.x = tiro.x+tiro.posX * dt
				tiro.y = tiro.y+tiro.posY * dt
				else -- Bala não movimenta
					tiro.x = hitman.x
					tiro.y = hitman.y
					tiro.rotProjetil = anguloVisao
			end
			if tiro.x > larguraTela or tiro.x < 0 or tiro.y > alturaTela or tiro.y <0 then -- bala saiu da tela.
				direcao = false
				mantemDirecao = true
			end
			if not parado then --Especial de tempo parado
				spanwEnemy(math.random( -500,love.graphics.getWidth()+50),math.random(-500,love.graphics.getHeight()),dt)
			end
			efeitoPontuacao(dt)
			colisao()
			addCanhoes()
			atiraCanhao(dt)
			colisaoCanhao()
			colisaoZumbiCanhao()
			barra(dt)
			tempoParado(dt)
			efeitoTempo(dt)
			if fim then
				fimDeJogo(dt)
			end
		end
	end

	function love.draw()
	 if not fim and not telaStart then --Jogo n acabou e o jogo n tá na tela inicial.
				love.graphics.setFont(fonte)
				for i=0, love.graphics.getWidth()/background:getWidth() do --Tiles background
					for j=0, love.graphics.getHeight()/background:getHeight() do
						love.graphics.draw(background, i*background:getWidth(), j*background:getHeight())
					end
				end

				for i, inimigo in ipairs(inimigos) do --Desenha cada inimigo no vetor
					angX = inimigo.x - larguraTela/2
					angY = inimigo.y - alturaTela/2
					angulo = math.deg(math.atan2(angX,angY))
					love.graphics.draw(inimigo.img, inimigo.x, inimigo.y,angulo)
				end
				love.graphics.print("Pontuacao:", larguraTela-(larguraTela-5), alturaTela-(alturaTela-10))
				love.graphics.print(pontuacao,larguraTela-(larguraTela-92), alturaTela-(alturaTela-10), 0,fonteX, fonteY)
				if mostraEfeito then
					love.graphics.print("+ 10", larguraTela-(larguraTela-80), alturaTela-(alturaTela-30),0,pontX)
				end
				love.graphics.draw(zumbiFace,larguraTela-(larguraTela-135), alturaTela-(alturaTela-10))
				love.graphics.print(limite,larguraTela-(larguraTela-160), alturaTela-(alturaTela-10))
				if (efeitoLimite) then
					love.graphics.print("+ 1", larguraTela-(larguraTela-150), alturaTela-(alturaTela-30),0,limiteX)
				end
				if (not efeitoMoeda) then
					love.graphics.draw(imagemMoeda, larguraTela-(larguraTela-195), alturaTela-(alturaTela-10))
				else
					love.graphics.draw(imagemMoeda, larguraTela-(larguraTela-195), alturaTela-(alturaTela-10),0,1,moedaY)
				end
				love.graphics.print(gold,larguraTela-(larguraTela-220), alturaTela-(alturaTela-10))

			--Personagem Vivo
			if (taVivo) then
					love.graphics.draw(projetil,tiro.x, tiro.y, tiro.rotProjetil,0.5,0.5,15,projetil:getHeight()/Imghitman:getHeight())
					love.graphics.draw(Imghitman,hitman.x,hitman.y,anguloVisao,1,1,Imghitman:getWidth()/2,Imghitman:getHeight()/2)
					love.graphics.draw(imgMiniCanhao,larguraTela-(larguraTela-300),alturaTela-(alturaTela-10),0,1,1)
					love.graphics.print("Preco "..custoCanhao,larguraTela-(larguraTela-360), alturaTela-(alturaTela-10))
					if custoCanhao ~= "Vendidos" then
						love.graphics.draw(imagemMoeda,larguraTela-(larguraTela-440),alturaTela-(alturaTela-10))
					end
					for i, cannon in ipairs(canhoes) do --Desenha cada canhão no vetor
							love.graphics.draw(Imgcanhao,cannon.x, cannon.y,cannon.angulo,1,1,Imgcanhao:getWidth()/2, Imgcanhao:getHeight()/2)
					end
					for i, bala in ipairs(tirosCanhoes) do --Desenha cada bala no vetor
						love.graphics.draw(ImgTiroCanhao,bala.x, bala.y, 1,1,1,ImgTiroCanhao:getHeight()/ImgTiroCanhao:getHeight())
					end
					--Seção do especial
					love.graphics.draw(barraVazia, larguraTela/2+170, alturaTela-30, 0,1,1)
					love.graphics.draw(barraCheia, larguraTela/2+170, alturaTela-30,0,carregador,1)
					if paraTempo then
						love.graphics.draw(aviso,larguraTela/2+215,alturaTela-25,0,animAviso,animAviso)
					end
					if parado then
						love.graphics.print(math.floor(timeStop), larguraTela/2-20,alturaTela/2+20,0,tempoEfeitoX,tempoEfeitoY)
					end
					--Fim seção especial
				end

			elseif fim and telaStart == false then -- Personagem morto
				risadaGameOver:play()
				love.graphics.draw(imgGameOver,0,0)
				if love.keyboard.isDown('q') then --Sair
						love.event.quit()
				end
				if love.keyboard.isDown('r') then --Restart
						inimigos = {}
						canhoes = {}
						quantInimigos = 0
						limite = 5
						aumento = 1
						risadaGameOver:stop()
						musicaPrincipal:play()
						musicaPrincipal:setLooping(true)
						love.load()
				end
			else --Tela de inicio é desenhada.
			musicaPrincipal:stop()
			musicaMenu:play()
			musicaMenu:setLooping(true)
			pause = true
			love.graphics.draw(telaInicio, 0,0,0)
			love.graphics.draw(botaoStart, telaInicio:getHeight()/2-90, telaInicio:getWidth()/2+70,0)
			love.graphics.draw(botaoQuit, telaInicio:getHeight()/2+140, telaInicio:getWidth()/2+120,0)
	end
end

	function love.mousepressed(x,y,button) --Ações envolvendo o click do mouse.
		--Clique no botão de start da tela inicial.
		if telaStart and button == 1 and x >= ( telaInicio:getHeight()/2-150-botaoStart:getWidth()) and x < ( telaInicio:getHeight()/2-150 + botaoStart:getWidth()) and y >= ( telaInicio:getWidth()/2+220 - botaoStart:getHeight()) and y < ( telaInicio:getWidth()/2+220 + botaoStart:getHeight()) then
			telaStart = false
			pause = false
			musicaMenu:stop()
			musicaPrincipal:play()
			musicaPrincipal:setLooping(true)
		end
		--Clique no botão de quit da tela inicial.
		if telaStart and button == 1 and x >= ( telaInicio:getHeight()/2+140-botaoStart:getWidth()) and x < ( telaInicio:getHeight()/2+140 + botaoStart:getWidth()) and y >= (telaInicio:getWidth()/2+120 - botaoStart:getHeight()) and y < ( telaInicio:getWidth()/2+120+ botaoStart:getHeight()) then
			love.event.quit()
		end
		--Clique dentro do jogo para atirar. 
		if button == 1 and not direcao then
			tiro.posX = math.cos(anguloVisao)*900
			tiro.posY = math.sin(anguloVisao)*900
			direcao = true
		end

	end

	--Função responsável pela animção do especial
	function barra(dt)
		animAviso = animAviso+0.1 *dt
		if animAviso>= 0.6 then
			animAviso = 0.5
		end
	end

	--Função responsável pela animação das pontuações, moedas etc.. 
	function efeitoPontuacao(dt)
		fonteX = fonteX-3*dt
		fonteY = fonteY -3*dt
		pontX = pontX + 3*dt
		limiteX = limiteX+3*dt
		moedaY = moedaY-3*dt
		if (fonteX <= 1) then
			fonteX = 1
			fonteY = 1
			pontX = 1
			moedaY = 1
			mostraEfeito=false
			efeitoLimite =false
			efeitoMoeda = false
		end
	end

	--Contador do tempo do especial
	function efeitoTempo(dt)
		if parado then
			tempoEfeitoX = tempoEfeitoX+0.5*dt
			tempoEfeitoY = tempoEfeitoY+0.5*dt
			if (tempoEfeitoX >= 2.8) then
				tempoEfeitoX = 2
				tempoEfeitoY = 2
			end
		end
	end

	--Função que pega as posições X e Y do mouse usadas para calcular a trajetória do tiro.
	function movimentoMouse()
		mousex = love.mouse.getX() - larguraTela/2
		mousey = love.mouse.getY() - alturaTela/2
		anguloVisao = math.atan2(mousey, mousex)
	end

	--Pause
	function love.keyreleased(key)
		if (key == 'p') then
			pause = not pause
		end
		if pause then
			musicaPrincipal:pause()
		else
			musicaPrincipal:play()
		end

	end

		--Função do especial
	function love.keyreleased(key)
			if (key == 's') and paraTempo then
				parado = true
				musicaPrincipal:pause()
				zaWarudo:play()
				paraTempo = false
				carregador = 0
			end
	end

	--Função que calcula o tempo que fica parado.
	function tempoParado (dt)
		if parado then
			tique:play()
			if (timeStop >= 5) then
				timeStop = 0
				parado = false
				tique:pause()
				musicaPrincipal:play()
			end
			if (timeStop >= 4.5) then
				tique:pause()
				voltaNormal:play()
			end
			timeStop = timeStop+0.7*dt
		end
	end

	function fimDeJogo(dt)
		pause = true
	end



