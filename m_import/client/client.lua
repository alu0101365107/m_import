ESX = nil
importacion = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('m_importC:addCar')
AddEventHandler('m_importC:addCar', function(coche, matricula, blip)
	table.insert(importacion, {
		coche = coche,
		lock = true,
		volante = true,
		matricula = matricula,
		blip = blip
	})
end)

RegisterNetEvent('m_importC:openCar')
AddEventHandler('m_importC:openCar', function(tipo)
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local veh,dist = ESX.Game.GetClosestVehicle(pedCoords)
	local vehProperties = ESX.Game.GetVehicleProperties(veh)
	if veh ~= nil and vehProperties ~= nil and dist < 3 then
		if vehProperties.plate == "ESX" then
			for i, v in pairs(importacion) do
		      if v.coche == GetDisplayNameFromVehicleModel(vehProperties.model):lower() and v.matricula == vehProperties.plate and v.lock == true then
				local tiempo = 18
				local veces = 6
				if tipo == "lockpickA" then
					tiempo = 25
					veces = 4
				end
				if exports.lockmain:StartLockPickCircle(veces, tiempo) == true then
					v.lock = false
					break
				end
			  end
		    end
		end
	end
end)

RegisterNetEvent('m_importC:hackCar')
AddEventHandler('m_importC:hackCar', function()
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local veh,dist = ESX.Game.GetClosestVehicle(pedCoords)
	local vehProperties = ESX.Game.GetVehicleProperties(veh)
	if veh ~= nil and vehProperties ~= nil and dist < 3 then
		if vehProperties.plate == "ESX" then
			for i, v in pairs(importacion) do
		      if v.coche == GetDisplayNameFromVehicleModel(vehProperties.model):lower() and v.matricula == vehProperties.plate and v.lock == false then
				print("hola")
				if exports.hackminigame:Begin(3, 4000) == true then
					v.volante = false
					RemoveBlip(v.blip)
					break
				end
			  end
		    end
		end
	end
end)

CreateThread(function()
  for _, v in pairs(Config.Peds) do
    CreoNpc(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
	CreateBlip(vector3(v[1], v[2], v[3]), 480, 'Pedir Importacion', 44, 0.75)
  end
end)

CreateThread(function()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)
  local sleep = 1000
  while true do
		ped = PlayerPedId()
		pedCoords = GetEntityCoords(ped)
        Wait(sleep)
	    if (#(pedCoords - vector3(Config.Peds[1][1], Config.Peds[1][2], Config.Peds[1][3])) < 4) then
		   sleep = 1
		   Draw3DText(Config.Peds[1][1], Config.Peds[1][2], Config.Peds[1][3], 0.4, "Pulsa [E] para hablar conmigo")
		   if (IsControlJustPressed(0, 38)) then
		   	MainMenu()
           end
	    else
		   sleep = 1000
	    end
  end
end)

CreateThread(function()
	local ped = PlayerPedId()
	local pedCoords = GetEntityCoords(ped)
	local sleep = 1000
	while true do
		ped = PlayerPedId()
		pedCoords = GetEntityCoords(ped)
	    Wait(sleep)
		local veh,dist = ESX.Game.GetClosestVehicle(pedCoords)
		local vehProperties = ESX.Game.GetVehicleProperties(veh)
		if veh ~= nil and vehProperties ~= nil then
		  if vehProperties.plate == "ESX" then
		    sleep = 500
		    if dist < 10 then
		  	sleep = 250
		  	for i, v in pairs(importacion) do
		  		if v.coche == GetDisplayNameFromVehicleModel(vehProperties.model):lower() and v.matricula == vehProperties.plate then
		  		  if v.lock == true then
                      SetVehicleDoorsLocked(veh, 2)
		  		  else 
		  			  SetVehicleDoorsLocked(veh, 0)
					  if v.volante == true then
						SetVehicleUndriveable(veh, true)
						SetVehicleEngineOn(veh, false, true, true) 
					  else
						SetVehicleUndriveable(veh, false)
					    SetVehicleEngineOn(veh, true, true, true)
                      end
		  		  end
		  		end
		  	end
		    end
		  end
		end
    end
end)
