local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("york_meta")
--https://github.com/eboraci
--York#2030
--discord: https://discord.gg/fK5c6V5
----------------------------------------------------------------------------------------------------------------------------------------- 
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = { 

	{ ['id'] = 1, ['x'] =  1493.17, ['y'] = 6390.24, ['z'] = 21.26, ['text'] = "colocar os ingredientes", ['perm'] = "vagos.permissao" },
	{ ['id'] = 2, ['x'] = 1504.89, ['y'] = 6393.25, ['z'] = 20.79, ['text'] = "quebrar metanfetamina", ['perm'] = "vagos.permissao" }, 
	{ ['id'] = 3, ['x'] = 1500.67, ['y'] = 6394.03, ['z'] = 20.79, ['text'] = "embalar metanfetamina", ['perm'] = "vagos.permissao" },
} 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not processo then
				drawTxt("Pressione  ~r~E~w~  para "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					if v.id == 1 then
						if func.checkPayment(v.id) then
							processo = true
							liquidos()
						end
					elseif v.id == 2 then
						if func.checkPayment(v.id) then
							processo = true
							quebrando()
						end
					elseif v.id == 3 then
						if func.checkPayment(v.id) then
							processo = true
							embalando()
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function liquidos()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId() 
            local  targetRotation = vec3(180.0, 180.0, 180.0)
            local x,y,z = table.unpack(vec3(1493.17,6390.24,21.26))

			local animDict = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
    
            RequestAnimDict(animDict)
            RequestModel("bkr_prop_meth_ammonia")
            RequestModel("bkr_prop_meth_sacid")
            RequestModel("bkr_prop_fakeid_clipboard_01a")
            RequestModel("bkr_prop_fakeid_penclipboard")
    
            while not HasAnimDictLoaded(animDict) and
                not HasModelLoaded("bkr_prop_meth_ammonia") and 
                not HasModelLoaded("bkr_prop_meth_sacid") and 
                not HasModelLoaded("bkr_prop_fakeid_clipboard_01a") and
                not HasModelLoaded("bkr_prop_fakeid_penclipboard") do 
                Citizen.Wait(100)
            end

            ammonia = CreateObject(GetHashKey('bkr_prop_meth_ammonia'), x, y, z, 1, 0, 1)
            acido = CreateObject(GetHashKey('bkr_prop_meth_sacid'), x, y, z, 1, 0, 1)
            caderneta = CreateObject(GetHashKey('bkr_prop_fakeid_clipboard_01a'), x, y, z, 1, 0, 1)
            caneta = CreateObject(GetHashKey('bkr_prop_fakeid_penclipboard'), x, y, z, 1, 0, 1)   


            local netScene = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            local netScene2 = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(ammonia, netScene, animDict, "chemical_pour_long_ammonia", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(acido, netScene, animDict, "chemical_pour_long_sacid", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(caderneta, netScene, animDict, "chemical_pour_long_clipboard", 4.0, -8.0, 1)
            NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(caneta, netScene2, animDict, "chemical_pour_long_pencil", 4.0, -8.0, 1)
			
			Citizen.Wait(150)
            NetworkStartSynchronisedScene(netScene)
            NetworkStartSynchronisedScene(netScene2)

			Citizen.Wait(GetAnimDuration(animDict, "chemical_pour_long_cooker") * 770)
			TriggerEvent('Notify', 'sucesso', 'Você misturou os ingredientes.')
            DeleteObject(ammonia)
            DeleteObject(acido)
            DeleteObject(caderneta)
			DeleteObject(caneta)
			processo = false
			break    
		end
	end)
end


function embalando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local ped = PlayerPedId() 
			local  targetRotation = vec3(180.0, 180.0, 168.0)
			local x,y,z = table.unpack(vec3(1500.67, 6394.03, 20.79))    

			local animDict = "anim@amb@business@meth@meth_smash_weight_check@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_meth_scoop_01a")
			RequestModel("bkr_prop_meth_bigbag_03a")
			RequestModel("bkr_prop_meth_bigbag_04a")
			RequestModel("bkr_prop_fakeid_penclipboard")
			RequestModel("bkr_prop_fakeid_clipboard_01a")
			RequestModel("bkr_prop_meth_openbag_02")
			RequestModel("bkr_prop_coke_scale_01")
			RequestModel("bkr_prop_meth_smallbag_01a")
			RequestModel("bkr_prop_meth_openbag_01a")
			RequestModel("bkr_prop_fakeid_penclipboard")

			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_meth_scoop_01a") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_03a") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_04a") and
				not HasModelLoaded("bkr_prop_meth_openbag_02") and 
				not HasModelLoaded("bkr_prop_coke_scale_01") and 
				not HasModelLoaded("bkr_prop_meth_smallbag_01a") and 
				not HasModelLoaded("bkr_prop_meth_openbag_01a") and 
				not HasModelLoaded("bkr_prop_fakeid_clipboard_01a") and
				not HasModelLoaded("bkr_prop_fakeid_penclipboard") do 
				Citizen.Wait(100)
			end

			pazinha = CreateObject(GetHashKey('bkr_prop_meth_scoop_01a'), x, y, z, 1, 0, 1)
			caixa_grande = CreateObject(GetHashKey('bkr_prop_meth_bigbag_03a'), x, y, z, 1, 0, 1)
			caixa_grande_2 = CreateObject(GetHashKey('bkr_prop_meth_bigbag_04a'), x, y, z, 1, 0, 1)
			bolsa = CreateObject(GetHashKey('bkr_prop_meth_openbag_02'), x, y, z, 1, 0, 1)
			bolsa_fechada = CreateObject(GetHashKey('bkr_prop_meth_smallbag_01a'), x, y, z, 1, 0, 1)
			bolsa_aberta = CreateObject(GetHashKey('bkr_prop_meth_openbag_01a'), x, y, z, 1, 0, 1)
			balanca = CreateObject(GetHashKey('bkr_prop_coke_scale_01'), x, y, z, 1, 0, 1)
			caderneta = CreateObject(GetHashKey('bkr_prop_fakeid_clipboard_01a'), x, y, z, 1, 0, 1)
			caneta = CreateObject(GetHashKey('bkr_prop_fakeid_penclipboard'), x, y, z, 1, 0, 1)


			local netScene = NetworkCreateSynchronisedScene(x - 5.3,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene2 = NetworkCreateSynchronisedScene(x - 5.3 ,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene3 = NetworkCreateSynchronisedScene(x - 5.3 ,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, "break_weigh_scoop", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_grande_2, netScene, animDict, "break_weigh_box01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bolsa, netScene, animDict, "break_weigh_methbag01^3", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(balanca, netScene2, animDict, "break_weigh_scale", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_grande, netScene2, animDict, "break_weigh_box01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bolsa_fechada, netScene2, animDict, "break_weigh_methbag01^2", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bolsa_aberta, netScene3, animDict, "break_weigh_methbag01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caderneta, netScene3, animDict, "break_weigh_clipboard", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caneta, netScene3, animDict, "break_weigh_pen", 4.0, -8.0, 1)
			
			NetworkStartSynchronisedScene(netScene)
			NetworkStartSynchronisedScene(netScene2)
			NetworkStartSynchronisedScene(netScene3)


			
			Citizen.Wait(GetAnimDuration(animDict, "break_weigh_char01") * 770)

			TriggerEvent('Notify', 'sucesso', 'Você embalou a metanfetamina.')

			DeleteObject(pazinha)
			DeleteObject(caixa_grande)
			DeleteObject(caixa_grande_2)
			DeleteObject(bolsa)
			DeleteObject(bolsa_fechada)
			DeleteObject(bolsa_aberta)
			DeleteObject(balanca)
			DeleteObject(caderneta)
			DeleteObject(caneta)
			processo = false
			break
		end
	end)
end

function quebrando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local ped = PlayerPedId() 
			local  targetRotation = vec3(180.0, 180.0, 168.0)
			local x,y,z = table.unpack(vec3(1504.89, 6393.25, 20.79))

			local animDict = "anim@amb@business@meth@meth_smash_weight_check@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_meth_tray_02a")
			RequestModel("w_me_hammer")
			RequestModel("bkr_prop_meth_tray_01a")
			RequestModel("bkr_prop_meth_smashedtray_01")
			RequestModel("bkr_prop_meth_smashedtray_01_frag_")
			RequestModel("bkr_prop_meth_bigbag_02a")

			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_meth_tray_02a") and 
				not HasModelLoaded("bkr_prop_fakeid_penclipboard") and 
				not HasModelLoaded("w_me_hammer") and 
				not HasModelLoaded("bkr_prop_meth_tray_01a") and 
				not HasModelLoaded("bkr_prop_meth_smashedtray_01") and 
				not HasModelLoaded("bkr_prop_meth_smashedtray_01_frag_") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_02a") do 
				Citizen.Wait(100)
			end

			forma = CreateObject(GetHashKey('bkr_prop_meth_tray_02a'), x, y, z, 1, 0, 1)
			forma_2 = CreateObject(GetHashKey('bkr_prop_meth_tray_01a'), x, y, z, 1, 0, 1)
			forma_quebrada = CreateObject(GetHashKey('bkr_prop_meth_smashedtray_01'), x, y, z, 1, 0, 1)
			forma_quebrada_2 = CreateObject(GetHashKey('bkr_prop_meth_smashedtray_01_frag_'), x, y, z, 1, 0, 1)
			martelo = CreateObject(GetHashKey('w_me_hammer'), x, y, z, 1, 0, 1)
			caixa = CreateObject(GetHashKey('bkr_prop_meth_bigbag_02a'), x, y, z, 1, 0, 1)




			local netScene = NetworkCreateSynchronisedScene(x - 3.6,y - 1.0, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene2 = NetworkCreateSynchronisedScene(x - 3.6,y - 1.0, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "break_weigh_char02", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(forma_quebrada, netScene, animDict, "break_weigh_tray01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(forma_2, netScene, animDict, "break_weigh_tray01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(martelo, netScene, animDict, "break_weigh_hammer", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "break_weigh_char02", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(forma, netScene2, animDict, "break_weigh_tray01^2", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(forma_quebrada_2, netScene2, animDict, "break_weigh_tray01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa, netScene2, animDict, "break_weigh_box01^1", 4.0, -8.0, 1)
			
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)
			NetworkStartSynchronisedScene(netScene2)


			
			Citizen.Wait(GetAnimDuration(animDict, "break_weigh_char02") * 770)
			TriggerEvent('Notify', 'sucesso', 'Você quebrou a mentafetamina.')
			DeleteObject(forma)
			DeleteObject(forma_2)
			DeleteObject(forma_quebrada)
			DeleteObject(forma_quebrada_2)
			DeleteObject(martelo)
			DeleteObject(caixa)
			processo = false
			break
		end
	end)
end
