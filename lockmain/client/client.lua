local Result = nil
local NUI_status = false

ESX = nil

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

function StartLockPickCircle(circles, seconds, callback)
    Result = nil
	print(circles, "This be the lock")
    NUI_status = true
    SendNUIMessage({
        action = 'start',
        value = circles,
		time = seconds,
    })
    while NUI_status do
        Wait(5)
        SetNuiFocus(NUI_status, false)
    end
    Wait(100)
    SetNuiFocus(false, false)
    lockpickCallback = callback
    return Result
end

RegisterNUICallback('fail', function()
        ClearPedTasks(PlayerPedId())
        Result = false
        Wait(100)
        NUI_status = false
        ESX.ShowNotification('Rompistes la ganzua', 3000, "error")
end)

RegisterNUICallback('success', function()
	Result = true
	Wait(100)
	NUI_status = false
    SetNuiFocus(false, false)
    ESX.ShowNotification('Ganzuado Correcto', 3000, "success")
    return Result
end)