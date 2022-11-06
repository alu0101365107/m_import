function CreoNpc(x, y, z, heading, hash, model, animation)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(15)
    end
    RequestAnimDict(animation)
    while not HasAnimDictLoaded(animation) do
        Wait(15)
    end
    ped = CreatePed(4, hash, x, y, z - 1, 3374176, false, true)
    SetEntityHeading(ped, heading)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped, animation, "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end

function Draw3DText(x, y, z, scl_factor, text)
    z = z + 1
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(0.1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(2, 18, 17, 19, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function MainMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), 'ImportacionMenu', {
    	title = 'Importacion',
    	align    = 'bottom-right',
    	elements = Config.Elements
    }, function(data, menu)
    	if data.current.name == "pedir" then
            math.randomseed(GetGameTimer())
            math.random(1, 10) math.random(1, 10) math.random(1, 10)
            a = math.random(1, 2)
            b = 0
            for i, v in pairs(Config.Zones) do
                b = b + 1
                if a == b then
                   
                    a = math.random(1, 4)
                    b = 0
                    for j, k in pairs(v.posiblesZonas) do
                        b = b + 1
                        if a == b then
                          CreateBlip(k, 227, 'Ubicacion del coche importacion', 2, 0.75 )
                          local x, y, z = table.unpack(k)
                          ESX.Game.SpawnVehicle('zentorno', {
                            x = x,
                            y = y,
                            z = z + 1
                        }, pos, function(callback_vehicle)
                            ESX.Game.SetVehicleProperties(callback_vehicle, {
                                plate = 'ESX',
                                modTurbo = true
                            })
                        end)
                        TriggerServerEvent('m_importS:addCar', 'zentorno', 'ESX',  CreateBlipC(v.coordsBlip))
                        else
                          CreateBlip(k, 227, 'Posible ubicacion coche importacion', 29, 0.75 )
                        end
                    end
                    break
                end
            end
    	elseif data.current.name == "invitar" then
    		print("multiplayer")
    	else
    		print("Error")
    	end
    end, function(data, menu)
    	menu.close()
    end)
end

function CreateBlip(coords, sprite, string, color, scale)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)
	SetBlipDisplay(blip, 4)
    SetRadiusBlipEdge(blip, true)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(string)
	EndTextCommandSetBlipName(blip)
end

function CreateBlipC(coords)
    local blip = AddBlipForRadius(coords.x, coords.y, coords.z , 200.0)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 8)
	SetBlipAlpha (blip, 128)
    return blip
end