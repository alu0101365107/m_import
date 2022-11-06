ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print("dsa")



RegisterServerEvent('m_importS:addCar')
AddEventHandler('m_importS:addCar', function(coche, matricula, blip)
   TriggerClientEvent('m_importC:addCar', -1, coche, matricula, blip)
end)

ESX.RegisterUsableItem('lockpick', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpick', 1)
	TriggerClientEvent('m_importC:openCar', source, 'lockpick')
end)

ESX.RegisterUsableItem('lockpickA', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpickA', 1)
	TriggerClientEvent('m_importC:openCar', source, 'lockpickA')
end)

ESX.RegisterUsableItem('hack_car', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('hack_car', 1)
	TriggerClientEvent('m_importC:hackCar', source)
end)