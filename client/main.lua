ESX = nil

local E_KEY = 86

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- [+] Variables
local hasLoadedCar, currentCar, driverHasCar, currentPlate, IsHaveClothes = false, nil, false, nil, false

local IsInvMenuOpen, IsVehMenuOpen, IsMonMenuOpen = false, false, false

local options    = {
    {label = 'Withdraw Item', value = 'putstock'},
    {label = 'Pickup Item', value = 'getstock'},
}
local VeHoptions = {
    {label = 'Car', value = 'van'},
    {label = 'Bike', value = 'bike'},
}
-- [-] Variables

-- [+] Make Markers
Citizen.CreateThread(function()

 while true do
    Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())
        if PlayerData.job ~= nil then
        if PlayerData.job.name == 'fastfood' then
        if playerIsInside(coords, Config.Zones.Drink.Position, 20) then
   cMarker(Config.Zones.Drink.Type, Config.Zones.Drink.Position, Config.Zones.Drink.Size, Config.Zones.Drink.Colour, false, true)
        end
        if playerIsInside(coords, Config.Zones.Fries.Position, 20) then
   cMarker(Config.Zones.Fries.Type, Config.Zones.Fries.Position, Config.Zones.Fries.Size, Config.Zones.Fries.Colour, false, true)
    end
        if playerIsInside(coords, Config.Zones.Burger.Position, 20) then
   cMarker(Config.Zones.Burger.Type, Config.Zones.Burger.Position, Config.Zones.Burger.Size, Config.Zones.Burger.Colour, false, true)
        end
        if playerIsInside(coords, Config.Zones.Burger2.Position, 20) then
   cMarker(Config.Zones.Burger2.Type, Config.Zones.Burger2.Position, Config.Zones.Burger2.Size, Config.Zones.Burger2.Colour, false, true)
        end
        if playerIsInside(coords, Config.Zones.Prepare.Position, 20) then
   cMarker(Config.Zones.Prepare.Type, Config.Zones.Prepare.Position, Config.Zones.Prepare.Size, Config.Zones.Prepare.Colour, false, true)
        end
        if playerIsInside(coords, Config.Zones.CarSpawn.Position, 20) then
   cMarker(Config.Zones.CarSpawn.Type, Config.Zones.CarSpawn.Position, Config.Zones.CarSpawn.Size, Config.Zones.CarSpawn.Colour, true, false)
    end
        if playerIsInside(coords, Config.Zones.CarDelete.Position, 20) and IsPedInAnyVehicle(PlayerPedId()) then
   cMarker(Config.Zones.CarDelete.Type, Config.Zones.CarDelete.Position, Config.Zones.CarDelete.Size, Config.Zones.CarDelete.Colour, false, false)
    end
        if playerIsInside(coords, Config.Zones.Locker.Position, 20) then
   cMarker(Config.Zones.Locker.Type, Config.Zones.Locker.Position, Config.Zones.Locker.Size, Config.Zones.Locker.Colour, true, false)
        end
        if playerIsInside(coords, Config.Zones.Locker2.Position, 20) then
   cMarker(Config.Zones.Locker2.Type, Config.Zones.Locker2.Position, Config.Zones.Locker2.Size, Config.Zones.Locker2.Colour, true, false)
        end
        if playerIsInside(coords, Config.Zones.ChangeClothes.Position, 20) then
   cMarker(Config.Zones.ChangeClothes.Type, Config.Zones.ChangeClothes.Position, Config.Zones.ChangeClothes.Size, Config.Zones.ChangeClothes.Colour, false, true)
    end
end
    if PlayerData.job.name == 'fastfood' or PlayerData.job.name == 'offdutyfastfood' then
    if playerIsInside(coords, Config.Zones.ChangeDuty.Position, 20) then
   cMarker(Config.Zones.ChangeDuty.Type, Config.Zones.ChangeDuty.Position, Config.Zones.ChangeDuty.Size, Config.Zones.ChangeDuty.Colour, false, true)
    end
end
end
end
end)
-- [-] Make Markers

-- [+] Make Blip
Citizen.CreateThread(function()

      local blip = AddBlipForCoord(Config.Blip.pos.x, Config.Blip.pos.y, Config.Blip.pos.z)
      SetBlipSprite(blip, Config.Blip.id)
      SetBlipDisplay(blip, 4)
      SetBlipScale(blip, 1.0)
      SetBlipColour(blip, Config.Blip.colour)
      SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Config.Blip.title)
      EndTextCommandSetBlipName(blip)
    
end)
-- [-] Make Blip

-- [+] Make Markers Usable
Citizen.CreateThread(function()
	while true do
		sleep = 1000
			
			local coords = GetEntityCoords(PlayerPedId())
            sleep = 500
                  local coords = GetEntityCoords(PlayerPedId())
                  for k,v in pairs(Config.Zones) do
                            local _pos = v.Position
                            if #(coords-_pos) <= 1.6 then
                                if k == 'Drink' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        SetEntityHeading(PlayerPedId(), 131.4)
                                        SetEntityCoords(PlayerPedId(), Config.Zones.Drink.Position)
                                        startAnim("mp_common", "givetake1_a")
                                        Citizen.Wait(1)
                                        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                        local prop = CreateObject(GetHashKey('prop_food_bs_juice01'), x, y, z + 0.2, true, true, true)
                        local boneIndex = GetPedBoneIndex(PlayerPedId(), 28422)
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0, 0, -0.085, 10.0, 90, 0.0, true, true, false, false, 0, false)
                                        TriggerEvent("mythic_progbar:client:progress", {
                                            name = "harvest_drink",
                                            duration = 2000,
                                            label = "Getting Drink...",
                                            useWhileDead = false,
                                            canCancel = true,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }
                                        }, function(status)
                                            if not status then
                                                DeleteObject(prop)
                                                ClearPedTasks(PlayerPedId())
                                                TriggerServerEvent('esx_fastfood:cookedDrink')
                                            end
                                        end)
                                    end
                                end
                                elseif k == 'Burger' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        SetEntityHeading(PlayerPedId(), 216.44)
                                        SetEntityCoords(PlayerPedId(), Config.Zones.Burger.Position)
                                        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                        local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z + 0.2, true, true, true)
                        local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                        startAnim("misscarsteal2fixer", "confused_a")
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
                        DeleteObject(prop)
                        local prop = CreateObject(GetHashKey('prop_food_bs_burg'), x, y, z + 0.2, true, true, true)
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
                        Citizen.Wait(12000 / 3)
                        DeleteObject(prop)
                        local prop = CreateObject(GetHashKey('prop_food_bs_burg3'), x, y, z + 0.2, true, true, true)
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
                        Citizen.Wait(12000 / 3)
                        DeleteObject(prop)    
                        TriggerEvent("mythic_progbar:client:progress", {
                                            name = "harvest_drink",
                                            duration = 1000,
                                            label = "Getting Burger...",
                                            useWhileDead = false,
                                            canCancel = true,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }
                                        }, function(status)
                                            if not status then
                                                ClearPedTasks(PlayerPedId())
                                                TriggerServerEvent('esx_fastfood:cookedBurger')
                                            end
                                        end)
                                    end
                                end
                                elseif k == 'Burger2' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        SetEntityHeading(PlayerPedId(), 225.89)
                                        SetEntityCoords(PlayerPedId(), Config.Zones.Burger2.Position)
                                        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                        local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z + 0.2, true, true, true)
                        local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                        startAnim("misscarsteal2fixer", "confused_a")
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
                        DeleteObject(prop)
                        local prop = CreateObject(GetHashKey('prop_food_bs_burg'), x, y, z + 0.2, true, true, true)
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
                        Citizen.Wait(12000 / 3)
                        DeleteObject(prop)
                        local prop = CreateObject(GetHashKey('prop_food_bs_burg3'), x, y, z + 0.2, true, true, true)
                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
                        Citizen.Wait(12000 / 3)
                        DeleteObject(prop)    
                        TriggerEvent("mythic_progbar:client:progress", {
                                            name = "harvest_drink",
                                            duration = 1000,
                                            label = "Getting Burger...",
                                            useWhileDead = false,
                                            canCancel = true,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }
                                        }, function(status)
                                            if not status then
                                                ClearPedTasks(PlayerPedId())
                                                TriggerServerEvent('esx_fastfood:cookedBurger')
                                            end
                                        end)
                                    end
                                end
                                elseif k == 'Fries' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        SetEntityHeading(PlayerPedId(), 127.84)
                                        SetEntityCoords(PlayerPedId(), Config.Zones.Fries.Position)
                                        startAnim("mp_common", "givetake1_a")
                                        Citizen.Wait(1)
                                        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                                        local prop = CreateObject(GetHashKey('prop_food_bs_chips'), x, y, z + 0.2, true, true, true)
                                        local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                                        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, -0.1, 0, -0.05, 0, 0, 0, true, true, false, true, 1, false)
                                        TriggerEvent("mythic_progbar:client:progress", {
                                            name = "harvest_drink",
                                            duration = 3000,
                                            label = "Getting fries...",
                                            useWhileDead = false,
                                            canCancel = true,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }
                                        }, function(status)
                                            if not status then
                                                DeleteObject(prop)
                                                ClearPedTasks(PlayerPedId())
                                                TriggerServerEvent('esx_fastfood:cookedFries')
                                            end
                                        end)
                                    end
                                end
                                elseif k == 'Prepare' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        SetEntityHeading(PlayerPedId(), 138.11)
                                        SetEntityCoords(PlayerPedId(), Config.Zones.Prepare.Position)
                                        startAnim("misscarsteal2fixer", "confused_a")
                                        local trayProp = CreateObject(GetHashKey('prop_food_bs_tray_01'), Config.Preparing.TrayPosition.x, Config.Preparing.TrayPosition.y, Config.Preparing.TrayPosition.z, true, true, true)
                            Citizen.Wait(12000 / 3)
                            local friesProp = CreateObject(GetHashKey('prop_food_bs_chips'), Config.Preparing.BagPosition.x - 0.1, Config.Preparing.BagPosition.y - 0.1, Config.Preparing.BagPosition.z, true, true, true)
                            Citizen.Wait(12000 / 3)
                            local bagProp = CreateObject(GetHashKey('prop_food_bs_burg3'), Config.Preparing.BagPosition.x, Config.Preparing.BagPosition.y, Config.Preparing.BagPosition.z, true, true, true) 
                            Citizen.Wait(12000 / 3)
                            local drinkProp = CreateObject(GetHashKey('prop_food_bs_juice01'), Config.Preparing.DrinkPosition.x, Config.Preparing.DrinkPosition.y, Config.Preparing.DrinkPosition.z, true, true, true)
                                        TriggerEvent("mythic_progbar:client:progress", {
                                            name = "harvest_drink",
                                            duration = 1000,
                                            label = "Preparing package...",
                                            useWhileDead = false,
                                            canCancel = true,
                                            controlDisables = {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }
                                        }, function(status)
                                            if not status then
                                                ClearPedTasks(PlayerPedId())
                                                DeleteObject(trayProp)
                                                DeleteObject(friesProp)
                                                DeleteObject(bagProp)
                                                DeleteObject(drinkProp)
                                                --
                                                TriggerServerEvent('esx_fastfood:cookedPackage')
                                            end
                                        end)
                                    end
                                end
                                elseif k == 'Locker' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        OpenMenu()
                                    end
                                end
                                elseif k == 'Locker2' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        OpenMenu()
                                    end
                                end
                                elseif k == 'CarSpawn' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    if not IsPedInAnyVehicle(PlayerPedId()) then
                                        sleep = 0
                                        ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        OpenVehMenu()
                                    end
                                end
                            end
                                elseif k == 'CarDelete' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    if IsPedInAnyVehicle(PlayerPedId()) then
                                        sleep = 0
                                        ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        deleteCar()
                                    end
                                end
                            end
                                elseif k == 'ChangeDuty' then
                                    if PlayerData.job ~= nil then
                                    sleep = 0
                                    if PlayerData.job.name == 'fastfood' then
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~ To ~r~OFF', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        TriggerServerEvent('esx_fastfood:changeDuty')
                                    end
                                    elseif PlayerData.job.name == 'offdutyfastfood' then
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~ To ~g~ON', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        TriggerServerEvent('esx_fastfood:changeDuty')
                                    end
                                end
                            end
                                elseif k == 'ChangeClothes' then
                                    if PlayerData.job ~= nil and PlayerData.job.name == 'fastfood' then
                                    sleep = 0
                                    ESX.ShowHelpNotification('Press ~INPUT_VEH_HORN~', true, true, 5)
                                    if IsControlJustReleased(0, E_KEY) then
                                        if IsHaveClothes == false then
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                               if skin.sex == 0 then
                                            TriggerEvent('skinchanger:loadSkin', {
                                                sex          = 0,
                                                tshirt_1     = 15,
                                                torso_1      = 279,
                                                torso_2      = 6,
                                                pants_1      = 9,
                                                pants_2      = 7,
                                                shoes_1      = 8,
                                                shoes_2      = 7,
                                                helmet_1     = 2,
                                                glasses_1    = 5,
                                                glasses_2    = 5
                                            })
                                            IsHaveClothes = true
                                        else
                                            TriggerEvent('skinchanger:loadSkin', {
                                                sex          = 1,
                                                tshirt_1     = 15,
                                                torso_1      = 279,
                                                torso_2      = 6,
                                                pants_1      = 9,
                                                pants_2      = 7,
                                                shoes_1      = 8,
                                                shoes_2      = 7,
                                                helmet_1     = 2,
                                                glasses_1    = 5,
                                                glasses_2    = 5
                                            })
                                            IsHaveClothes = true
                                        end
                                        end)
                                        else
                                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                                TriggerEvent('skinchanger:loadSkin', skin)
                                            end)
                                            IsHaveClothes = false
                                        end
                                    end
                                end
                            end
                            end
end 
Citizen.Wait(sleep) 
end 
end)
-- [-] Make Markers Usable

-- [+] Make FastFood Number In Phone
RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'FastFood',
		number     = 'fastfood',
		base64Icon = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTEhMVFhUXFxUVFxUVFRUVFxUVFRUXFhUWFxUYHSggGBomHRUVITEhJSorLi4uFx8zODMsNygtLisBCgoKDg0OGhAQGy0lICUtLS0tLS0tLS0tLS0tLS0tLSstLS0tLS8tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAOEA4QMBEQACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAADBAABAgUGB//EAEAQAAIBAgQEAwQHBgUEAwAAAAECAwARBBIhMQUTQVEiYXEGMoGRM0JScoKhsQcUI1NiwUOS0fDxFRZzsiTC0v/EABsBAAIDAQEBAAAAAAAAAAAAAAIDAAEEBQYH/8QANREAAgECBAMGBQMEAwEAAAAAAAECAxEEEiExBUFRE2FxgZGhIjKxwdEUQvAGM+HxFSNSU//aAAwDAQACEQMRAD8A+itD2r5y4nXUgTLbeqsGiqhC1NtqhGrhkl70akA4hCKjVwQEkdvSkThYYpXB0sIlQgeJ+lPpyvoxckXKtxTGiouwvQDBmNrijTFtagp11pFRWdw4vQHSwg0B3p1J6NATKnG1MkSINNx60K3Cewy21G9hQrWQcSoQZjGgrVDSKFPcFOdaphx2BgVRY3TBQvMdazVHdjIrQxQBEqEN8s0WRlZkHDXrSmnsKsy6sgJ4e1C0EpAmW1CHcqoQ2klvSrTKcbh1N6LcWBkjtqKROFtUMjIHSwiwaidiDKNcVqjLMhTVgEyWPrVMKLLhbX1qIkkElGlSoroqL1F6zDAkB1plJ6gz2NzjSnSBjuBTceooVuG9hltjRy2FIVrGOJVkGxWsSKubk0DGo1CutWtwZPQYJom7K4ApesjHEqENxrc0cI3ZUnZDFaRQpWMcEWU0xVGgXFBFkBpsaiYDi0bIoygLw9qBxDUgVUEWjWqIpq4yjXo73AegGWO2vSkThbVBxlcHSwjcTWNHCVmVJXDSLcVoYtOwsKAYNKbij3FbMVIrIxxqPcUUPmKlsGm2rS9hcdwMe4oEG9g8mxop/KwFuLVlGmohqKKCvIqWwdzYVpYtbi1AMDwLp60UQJEnbS1BVeli4IBSAyVCDES2FaKcbIVJ3ZujKFKyDiVCEqENrIRRxm0U4phUkBp0ZpgOLRbxg0Vik7AHQigsMTKVrVCNXGFa4o9GhbVgMiWrPOOVjIu5igLGIWuK0U5XQuSBTLY1bCi9DcB6VcQZIxKNaRUWocdjKbihjuR7DEuxrU9hcdwEW4oVuHLYNNtVVPlBjuL1nGBcOOtOpLmBMuc9KZIqIJRc0IbGrUwULO1zWWTuxqVkZoSzcSXNHTjdgydhitIsHzxVXCymTD50l0uhamYKEdKBwaCujNCWSoQlQgRJbb0yNRrcFxuGuCKemnsBsBkjt6ULQSlcwrWqkwmMaMKJpSQvZi7LaszVnYYncuNrGrg7MkldBphcVpa0Fp6goTrQrcOWwSSMk6Dp8h3J6VfYTqytBXYKkktQRW1trHYggg+hGlLq0J0ZJTX+QlJMNNtTXsBHcHANaGIctjU52oKrKggNJDGYxYVpgrRFSeoCRrmow0rBIF61aQMmXM2lqGpKysSKAVnGEFS1yDSLYVqjGyFN3BzP0qNlxQGhDGQ470dxdmaqyiigNC4J7lptA2h7UqVLoEpgiLb0tpoO5VUQtWtVptbEauHSS9PhNS0FONiv3YsfACfIdKdTw9Sq7U02TtIr5maWHL7zxr3Ba5+S3rXHh04/PKMfO79EV2mb5YtmZZIT/jLf7r/rapPh9OS/ur0ZI9ov2MiYbN9GySfcYE/5TrSJ8LrWvTan4PX0L7VL5k14hYIWYe63bY0NHDV6isoP0YM5xXMHLhWQZpPCo6mx+AF7k1oXDa0Xeqsseun0LVaMtI6s87x7josRfJGOl9/M9zWm91kgrL697/mhsoYazu9WH9k5JJIWuhHj5i9SyMApOXoQUv6MO1KxdLtKKjDVxd2vGy08OYGKUYVE78ree52sRt8a50k1oxEdWTBpc27kD50eHp9pUUOrRVR2VzlQcdV2syBV6EXzL5m5s3pXQqUqEvgcbLa63Xf3+A79PKMbp3fsdIR6jW4OoI2I8q5NXDTpTUZbcmtmv5yFqaaCyNYUbBSuxdRegGbDNrCj2QrcXdrmssndjUrGaosNCnWn0482Lk+Rt2sKY2UlcWNAMJUISoWQGoUbEpq7spxQRZh1q7guLN6GrtcHVA3h7UuVK+wan1BEWpDTW4YSJQAXckItr23JOyr51vwWEVVudTSEd+rfRC5yd1GO7FcTxJmuvur0RTp8T9Y1054iTWWPwx6L79Q6dCMdd2LF76Cs4/vFJGqwxN3ym4JBGxBtY970S0Ctc9BwX2jmcGEuokP0ckilgbEXVlVlJNr2N9/z7GDx0m+zm/B/Y5+IwcIvOlpzS+pzPajjZPic2UDwj/fU1gr15Ymd+XJGvC4XIrLc43DOFGUpiJmIF7rFa1tbKW89j8RSZVVT+BLzNc6qgnCPqOHBYiLFrPBJuVLKz6hBZWuCfEhAv3ue+zsPiFSs+hmk4VKThNfzkejxft1hEmbD4qNoyDo5XPGyNqjhl8QBBB20110rtVJYetpUjdGKnwvESpKrRd+7ZruB+03F8JFFZJfpkuMhJIjce+Cuq3Gx9bVzq+Fp4aWah8z26Lv8y8NSr1J/EvlfPqvweGucM4UkGFieU4N7DQhW7aMPnWO3aK635nZa7RXW/M9dwXiYHhbVD81P2h/vWgTjJZKm3un1X81ObXot/Et/qdbE726bgjYg7EeVcytTlTm4v/feIg7q5qBOtAkSTMzP0pVSV9EFFAqUEEiS/pRwhmBkwxNaBYs7XoGMSIi3qJXLbsG5IosoGchhFSyJmZRg86mUmcyYTVWZeZGCpHSqsFcoGoQIs3erTBcQoINW7MHVCHHcRkKRjZUznzaQkX+AH5115RVOjTprpmfiw8NHO3N9behyEl631+N/WkmxrkWZahLApZKuxEhSVx8f93qw1cCGIsQSCNQb7He47a0UZOLTW5JJNNM7eKfDTGDEMcjcwqgc5EeXKGy72DagjoTsQTlroyoqtB1KGjejT69xzcLi6mWVPdLn0RzE/e4cUc2eSNn1v9RWOtwfcy/IgfLDJQtZqzXI6KdOVMPxDCQyYpOXNyp0CiwU2ZR4go2F7E7HY7dqi2oaq6YEHJQd1dDHHeBw4to1kkyvGSehd4CbtGALag+6emtacNXioZanLVfglDE1cOpOCun7Pr+Tn47gkUmKJlnUcxswh2bUaJe+1hYCw0FKeJlO8svn0ChUlGklFbczocT4bHOgicWtqCn1SPDobWI6a9qyqq4O8SqFWUH3+x5/BzcmVsOzXynwt3FtvUbfA0+cc0c6RpnHPHOj2nBp86hG6XKH82X03I8/Wlygq0Mj3W33X47zmV4ZHnXn9mPyvauTOVkLiri9ZxhpFvRRjmZTdhi1q02shW4CR7+lC3cYlYyq3qty27DKrajSsLbLqygPO8qR2rDyF87yq+17iZC+cKJVUVkZoOO9WpxZVmQoDRWTJdoG0PaqyhKQNgRQsK9zi+1xdZ8zD+GUXlkA6KB9bzveu9irZ422ssvh3mfC4lU24VNr7nLjnB2N/Ss1jqxcZK8WbMtQuwNpKhdheSdRudew1PyFXZiqlenT+aSN4XCtOG8QjUbljYm/Sk1ayp2yq77jBUxM8ReFLRc2dnHeyiYzDRRrI2eESZHClomMhzkOOhIy+IHa29dHh1epVgqUqckuT5eYeCr/AKGXxJNPdbPyOP7LxcWVVU4R5YgAFWZhC6DskjnMB/SQw7AV0XhnVVqkb9+zOhi5YG+anUUX0SbXoekm4EJGSWWCSN0NxnIuApzayRM0ZUWNsxX0FZanD6sIvs3p0ZghjErxT36fh6nD4lhI8S6zRTBXWwzb3AJI0B8LC/xvXPjOUFlaujbCTheMjfDOFwRzhpJxJMSWRTYakE3Iubta/wDpRSnKUbJWRKlSUo6LQx7TccaJhDEADYG+W5u2wVep/wBaqnRjNXYVGkms0iHhc2Jw6iWwxAOZXKjMqZicrFdtN+m1FTd6lqauuhUasaU2/wBvset4dwuREWwzkKBmFgALWJH2mPloL7mtM8FWpU3OMbyfJcvzocyti41ZZVovqZe99d68rO6k09xytyLVb1UYuRG7BwABWmKUVYXqwMkl/SqbDSKRL1SRG7DCrajSFt3BySdBSp1OSDjEDek3YdkSoQlQhKhCVCFg1d2SxsSmjVRoFxQSOUXGnUad6dSqLMtOa/0BKDszhe2/E2inERChXiDgyAyKZOZqCBrlAW2guCwNehxfD6cqueV1Jre/Pp4DsDh416Lb1s7W7jhx4nDvczJGhP8AiRSX6dI9x6W+VYZ4KvTV6c0+5hVOGq96d17f4HBFglW3NZ2YXH8Ug/C7AA+RrHBY6rOySVgI4atFauXi2zizO2UqMM1v5k8gH5FgoHxrqrBVr3lLyS+4UMLTelSb9xTE8SK5FRkOUHNljBVmJNgCdTYWF7+nemfp4Rd7X8Wa6ODwyTuvC+477PYE4yUgqiIi55ZZC7hF8lkcqSbdRbQnprqoUlJ6JJLcLEYiFCHw3beyVl9Ee0h4wkC8rDAohJJlk8UkjGwJCsRlvYb9rZRpS6vFoU7woq9uZg/Q1Kz7Srv02shDHcaOhkeQ3NgDJJdj5JEVHyFc/wDX4mtK0L+rX0sao4KnBXdvRfe4vD7StE10d7/yXEpEn9IV7kE7Ajy36voYjGU6izJtdN/rqVUwlCpB7X66fY7seEwEDSlJSokfMVRGkVGtYqCikCxB06a1sxNPDZ7yqW7lyMMamKnFLLe3NiHCfY6NX58c4m1YiRrAR/aLC9y9iRc7X2FSeDlUS7KScXzDqY6Vsko5X0OkyYIEZpWPTOEcqRr/AIuUi2+ualfpsJFqM6n4/AKq4l6xh+fQWxcMUdhiG5+bxpBDeOAR5jy3l1Jlvb65YEjRdCa2Va1DBRSa32SBpxq4hvJp1b3v3dPIS4lxaZgXWSQPa4CMyqDbRVS9mA01YG9ug0rjVuKValROErL+afz2N9HA04q01c9BMwlWOZSCHUXI2zro4t0sdPhQcaoZqsa0NpL3RzaLyXg+TK0ArlpKIzcA73qnqGlYuOO/pUSI2H0AotEherAySX2pE6l9EMUQdLCJUIF5PnTeyYGcnJ8/yq+y7yZy+T51Oy7yZyjD51XZMvOZ5RoXTkTMiih7VTg0XdD/AAXDZnzHZf1O1dvgWE7Ss6sto/X/AAZsVUtHKuZ4zjmKi4nzypAbCy5UcC+aB1ClmF/EOYhNxsCPj3cXUzQckr2ft/s30sPPB5L/AL179PRnlT7O4onLEgk/8ZJPxB2rFSnGo7JO5rlinFfFK3idCD2MkSxxc2Hw19hJIHkPpGu/wNa3QsvikkZXjc7tBOQzB7N4Ib4meQ948JIq/AkGl5sMv3+hXaYn/wAJeLBz+yuFkIEeO5Z2y4iB4gfxmwvRQ7GatTmr95Tq1o/PT07nc9D7N+zBwwnWbwwOgWWRnyk21jMTDzJ+Y66UdCFRZ1WSUbGbEV4zcHT1knoJTYOASloVbKNFZ2Znbu5ze72AsNPWw4OPr02+zoL4evU6uHVXLeq9foMcFx6YaVpZEWRjopzBTGnVUU6Enqbi+2laOHY2nQ0yPxFYzDVMQrRlp0Opxfj4nF0P8HoDcczQEs/UINgv1tSdNK1cQ4mm8lP/AG/x9fAyYTAOLvPf6eHf38jzP79JMTy7ZRpne9j5Iotp8hXHqRtrVbbfJHWjGMdIoJw/EMMyl73s0iBbJmRnRRa5zAZS2u9108NaqlZ0KMYU3pLV3+gh0VVqNyW2i+oJuJOWBZTZgcoszSMwNgMo2vrYb0mWGlNL4s0n33t5DYuEbpaJD88GXko4tLFFlk12MjmRYj08CsP8/lWriclCFOi90tTNhHmlOovlb0/Ixwjg4nUSzYgwxu5SJQUVpQDYkMwvqbgAeXetGC4ZSdOM6272E4rHTpzcKavbd9D0XDsPbDkKnLWIsixXzEFWPMZm6lj4r9RY9a2cTwqnhvgXy/TmctVJdtebvcVJJNeQ3N2iCpD3olEByNPIBQymkRRuBZiaTKTluGkkZoSyAVErkN8o9v0o8kisyCGYU/MgMrK5w7VMxMpXP8qmYmUnP8qmYvITn+VTMTIXzx2qZishPaviJwvDZJFNndcid80vhBHmFJPwr2GCh2GDXV6+ovB0f1GMjF7J3fgj5d+z0ZcS8xYrHBBJLIFseYgsvKIOhDEj5dN6qha7b2S1PS8Xf/QoWu5SSXc+p7QcSlcBWbkxfysMAlh2MnvMfMZa5NTisr5ILLHu3OVHAxis3zS6yKinSO/JhRCd3YcyQnuWbr8KyTxrv8MfN/E/fT2HLDNr45N9y0Xt+TT8TmP+K/wYgfIUp4yu/wB7DWFor9q9BVzm97XQDXXQCwHpas7lJu45RUVZIRmxbxlIblogbohbSMllU2vqQM2g6XNdNVquIw7g5aR1FdjThPOlq9DqcL4b+8ziIsyoFMkhQ2Yi4VVB6XJJ9FNFwnBxrzbnshOOxLoU7x3Z1+McHwUOGmMUUbOpWFmb+I6PKyLcs1yGAkDfKu/iIUqNCUoJXS9zl0K1erWipyeuvROx5jHxEqFBCpu9/sjpavI4ecYzzNXfLxO+1pZBCDk8GhI0v0vrc2663oZSzVM1TrqRKysgMODKhVWQqNcz5RIxJO+UkXFyTYG/qd9NOrSqT/7tFy7gJ5krxV36BQjANeS9mukmQIRlsQ2XMbEEE79vQA5wp1lKg27e5EnOFprfkZxEheMshLF9c2mY5j4m1sL6k9PhVObnXzVn3suMFCOWPLYmOxoMkSlbquQLEp92NPo4lP8AUVF27Bj0AHRjiO3q9rLSEdkZlQ7Om4r5pbv6s7EntLi1u/8ABI1JiEZCkW1HMve9hbMR8KYuNylOzisrEf8AF02rXd+p2VmQokkfuSIsijqAwvY+lcziFGFCpaGzV15mOGZ3Ut07AnlJrmSqNjVFIxQBEqECLEeulMjTb3BcgyqBtTlFIW3cuiIKCljTQjParsysyNCE96mUrMjQg86vKVmL5I71MpMxRgBsNdSB86ZTpZ5KPVlObSPOftpxdkw0I2JeQ/gARf8A3b5V7LF6RjFG7+nqd51Kj6W9dfseV9jcORBjZTexiXDKPtSTOtgPQKD8azJqFKc30sdDik06lKkt75vJHp7V5J6spbGeHcPkxLSlZlhiitnkZQ2pBJAuQBYWuSetdrAcOjWhnnoZMXjOwailds6nC/ZTDT3yY+WUj3uW6C3qLEiupS4dhn8rv6GCrxHEQ+aFvG44PYOAlgs+KBW2pYW1F9CUs3wpv/GUHpb+egr/AJWstbL+eZnAeyMIkljY4iQmMoJXUBEzZT/DP1n2N9RoR3q6WBpQzRSevoVV4hVmoy0VneyOj7N8EOFkYyzCR5AFXKhQZUuSTqdTmosHgo4W6T3FYvFvEJWVkvuNcQ4JAeczsUE4VX8YVSy+44B2kFhr5DStM6UHe/MRCvUWW37djz83siYwZJpHxEaWbkxRBXl1Fg3i1HcC165tPhVKlLPv3HRfE51FkilFvmEPsO97LiSsPReWDKq/ZEl7abXIqS4NSlUz38ilxaShbLr1BR+ywku2CxGWMMyFJY2bK6HK+ViQ1rg96qtwqjWeaLsFDiU6elWN3vow+E9kYw6jFYgSncQjLGrW7rcs4/KmUOF0KUrvVi63Eqs4vJGy6hMf7FsZGME4jRiWKNHnyEm5yEMLC+tjtVYjhNOrPPexKHFJQhllG9udzzUuDjSd1jJYRkxl23kl05rabAaIB0s3euNxNwp2oU9ludPCynUXaT3fsuQLGZmyxRi8kpyKPXcnyA1PpWPBYd1qiSNNSapwc5cj1Zw4jSNFN0WNUQ91Tw3+JBPxFO47TyV4rllXs2cKhUz5pPm2ylQmuMot7DroIsPc01UuoLmFCgUxRSBu2ZaUCruiKLBNITQ3DUTFUWNijFbmTIO9U5xRaizBnoHVQWQyZj5ULqsvIiuae9D2ki8qJhXJljF/rL+tbOH3liaafVCqtlBnjf2uRvLj4IY1LMYVyqNSWeST/wDIr2GLvKooo6/AnGnhZ1JOyvv4JfkYiwPISHCaXhBmnsQQcTLoFJG5RAR8RXK4rV7OmqK8WLhU/UVpV+T0XgvybxD5VJAJIB0GpNcGEc0kjYdn2b4jg4sIsE4e73aXPh5shdzcgnJYgaC+3hr19DEYanSUJNHBxVHEVKzqRXhqj0HDv3VWjfCQIyyZkaWBYwqBRm8ZFuoAt3rbDs07wW/NGGp2rTVWT05O/sc7iPHpJiy4ZxHChyviSA126rCp94/1a+XesOJx9rxptK28nsvy+41UcGo2dRXb2ivq+h53FIjG+aZzf35ZXLHTtey69q8/Xx05P4ZS8f8ACOvSw9l8SXgkPcE47JBIiSOzwOwTxks0TMbKQ51KXsCCTa9x2rpcM4nOU1Tqa3MuNwMHBzgrNe4/7XYODnq8qtiJWUJBhb+AEE5pGA+rqL37WsdLdTFyp03nnq+S7zDg5VHBxh8K5y5+BzsfIzfTzPI9x/CiYxQIBuvhN2NtNb279K4uK4hNaOWvRbLub6+G3U30MOmvgjZdXq2IwSSRHNBI6MOmZmQ+TIxsR+fnWKhxGtSlfNdGuphaVRWkj3PAeLHERLL4VADrKhvdZFI2a9gu51GoZdq9fQrKrBTWx5zEUOxm4Py8Dxow6PNJPE1lMjE4yQB3JJNo8Mh0AA0z2v2sLGuTXxEYSlKD8ZP6Jc34HUhGWSNOS5fKtPOQviIIybgOxv78jsznbre4N77Hr5VxKuNnKV4yl4tnQpUWl8SXgloVFGFFhoBfudzckk7m5NZJzlOWaW4+MbbCK4/lf/I+tJKuFg8lzA4mUfhOQEbFq9Jw2iqNPO92Y8RB159itopyfpoj6VxhAMmwsCB6C1J4/FZqb8fscTCt2aOaZRXn7o1ZWYabtUzBZQZYnehCSKAqENiI1dinI3yfOplKzAixNZ3JsOxVUQlQhBUsyGxEaYqbYLkiYNbTR/eH62rpcPpqOIpvvE1pXgzm+06svE5JV0ZeGTMjfYdXfxX6aNa/nXrqt1Ntf+WPw0k8CoP/AOiuuqscnCKAigCwyg263IuSfOvE1ZOU22+Z2IqyCjFcs5g+UjrexqU3OLzQvck6amrSRmX2i0IbEEg7guWB+Fae0xUt234iv0tJaqKRzouIO8rCAsiSqwlZRlDoDrl891uNs1aqdWthqUm3a+yKnRpzy31cTrYnEjKosFSNbKo2FhqfU1z6lWVXLFbLb7vxCpUVFtvVvmIRNNeJ2ULHMJDGD75VAPHbopzC3/Faq+C7KgpvdkjXhObhHluZ401oW+FvW4tWbCJusrDmrpnSgxzlpJn+llA16xp0jXtp17lu9asTj5zqSa8E+nW3iY6eFioxjyXu+8SdpHZo4ACVRpHZvdjRRe58+wocFgnX15IdWrQpJOXMLhnLIrHQlVJHqAf71hqJKTSGoBgcexSfDKSFeYvKR/LCIuQH+phr5Ke9dj9U6GDUFuzLUw6nXVR8l7jfEuIAKC1lRAFVBsB2HmTXNlKVeSSWi2XT+PcdSpKCbvvq2JR8/mgSLyxkz5PrANcIH+yTYm29hWjE4WOHprN8zJCtGp8mxviMpVDl1ZrKo7sxsP1rNhqfaVEhrkoptnA4+4OOgwqG6YdosOLbNJzAZ3t3MhIP3BXqpJKUaa5W9QcFBrC1K0t5qT8rOx9h9oASUt/V/audx9/FTXj9jzWD0ucoRGvPWNmZGhD51eUrMbEQq0gczNVNEVqZMgoXUii1Flc4UPaovIwFIGGlQmijFsptIKsPemqkuYDmaJAplkitWDebtVZglE58k5DK3Zg3yN6fQm4zjLo0VKKs0P8At465EQe/ORGT15CHmSD0PhH4q9ZxOv2dBtbvQVw2DlU12Wvnsjzbta5NeMWrPRJcjz3FsaIIo5eTFLNiGkcc4MyxwIciWQMAWZrkE30Br1OGowo0Y5ldszQpzxVaUYyajG23X0OQvtNiyQIxhoySAOXhYAbk2GrKa0KqtopehpfCoJNzk3bvZ77ibE4mW5vyxFAD35aBnOndnPyrjcZqXrKHQwcPjakn1uxNsLz5YcP0kfxW/lqMz/kLfGkcMo9rWVzRiavZUZTQ9xbGCbEM6W5Ua8iK2xCm8jDyLAAeSU/jGJU5qnHZGbAUXTp3lu9X9jicUIZ4ou7At90b/wB6x4aOWMqnQ3vY6Ur2BJ8zWOKu0i0FgtHgAg+mxxLueq4fqfTJoPOQ16ic44TB97OS06+Lbe0PqL4mUIpboB/wK8zCLnJI6yQjwCP+GWO7sSfhp+ub51qxr+NR6IFau41hcQi4nPIpkMShoovtysTZmOwVbEk9NPStnDpUqMHVn/GZsXGpOKpw0vu+4MCxLO5zSOxd22BY6WA6KBYDyFc7FYiVeo5sdSpqnFRQxBg8ssU0jKqR3lCnMWZgp5bFVByoDY3PbS9dLh0I0ZKpV06Ln6GXFVe0g6dPV8+n+zzv7uMIQyqJZWOc4p1VgXJzEwowIWxPvMMx38O1dD9TBt9nv1e/kh6nKtHK9IpWyrp39fDY9P7Ke0MuJSUTeJoilnsFzLJm0YDS4KbjofKsHE5OdFVJbp29Tn18NClNZNE+Xh/s7XO8q4HavoLyFGY1XasvKjJkPehc5MtRRm9DcslQhKhA6xCtCppbi3I2zW3o72KtcC8p6ULYSiDqgggh70SQLl0E8XYCmqSigHdiPHZS2JUE/RYeJfxSXdj8lSurxabyU4PojZw2CUG+rfscvHqzhYk9+VljX8RsT6AXNYMFRdWskdGc1Tg5vkeQ9rcasuKkyfRx2giHaOEZBbyJDN+KvR15LNZbLQ18Lounh03vL4n5nNwUwSSN22V0Y+isCf0pcHaSZrrxzUpJc0/ofS8TpiMSp35zP6rIFdD8jXI4tFrEN9TgYJp0Y+AKSG5DXZSAy3U5TlcWYX7Edqx0cTUo3yczROCmrMqeZY0ubBVFgOgA2ApcYyqS72GkBbAZFjxEhHMaUBkvrDHJE/JDj6pbU69xXdrYPs8HpuYoYntK7itktO9p6jbqCCDsdDXn02nc2mIYQvUk5VS7G5CILKo7KO1OrYidZrMxcKajsLc2N3LTNlw0BV536Mb+CId2Y9O166nC8JeXaT2QnF1XGOSHzS2QwiZJJojukr/FHYujDyIYVl4lScK7fUPDTU6cX3DEUbMcqgknoNaxU6c6jyxV2MlOMVeTsMxhIxmcqWG5OsUfqf8AEbyGnrXQp4eFJ/8AqXsvy/YxVKsqukdF7v8AC9zkcS4kroXbOyMxFr2MjKLlpG3A7Af8NtN1Gr67tsOFNxeWNvx4AIcA0yqXAii3WNBYm/1iT+vXyq7qm9Hd82ws6pt21fU9J7P4WOONooxY3Mlybl9gb+YG3lf4pxV69Bpbxu/Hr5pbeZiruWdTl4eA/lPauHlZVyWqWZCWqWZCZT2qWZLovIe1XkZV0Xyj2qZJEzI08vb51obBUQRNCEbSMmrSKcrB1UCi2QF2wUkvalSq9AlE5uKFSLuWzlcZxQWVZm0SWKMZuglhujoex2Poa72OpyrU6dSPRepq4fJZXDmm/RiH/VlgBxrqSAeVh12Ls308q36LHmAO2ZgK18Mw/YR7SYzEwliZfp6fi/svM9Zxfh2EnI5sEcisqskq3jcxkXQiRLEi3ekYriNTD15U6sVJbp7Oz7ziUcZiMO7Qk13cvRnmsb+z3DPrBiHj/pmQSL6BksQPW9FT4hhJ/ucfFaeqOvR/qCov7kE/DQPHwOdVRJpY88ahIsTGxdHiHuw4iMgMCuwYX032vW2dOhjIJZ4t9z/jMv6+nCblTTs3dxfJ9z+wi+KYXBxOA0JBP7yo1G/gPi/Kue+Da/MvU6Kxaavkl6HKxnH4IzmRxi5x7tlZcLE32jmAaZh0FgPWttDC0cPruwo0q+K+G2WPPq/wcjhnHHjkkeYGdJ9MQpNmk1urqfqup1Xp0pqqZm1PZmzEcPXZRVLRx2/neekwnEY2H8HGYdl6LiW/d5l8mz+FrdwTWCrwmEneEjCq84aVIO/dqjOM4lEo/jYyED+XhCZ5W/pDAZF9S1XS4VTg7zf3L7epPSnB+L0X5OHiMRNjnSCCErEl2jgDA26NNNIbAudsxsADYee5u6yQ0X81ZsoUIYVOtXfxPn9kvsj2vDOF2ijGIfmSxDKskLFF5I92OWRh/EA6FRsLXO9ZcTXoTiotZn3bfzwOS5NVJOj8MXyerv1S5eY7i8QyrlRMwP1EIRD2LMxzSfG/wrndtF/Amorov5r5lKKbvJ69X9uhxeITyCIPLGpbOVyODlW48ORAbHrrqauDjKplhKyty+5ogrytF+ZrB4B5MrzgKq+5CBlHe7Dp6H40bcYXUfVlSko3Ud+bOnLNSWwFEZ4C15Gf6qKb/ecZVHyLH4UUZZYTm+jXm9PyKxK+FR5t/Q7IlFcy5mys1nHcVLolmTMO4qFakzDuKu5dmTMO4qrlWZWcdxUuXZiwFAMDJF3okgHI2z2qSkkUlcA73rPKTkMSsZoSwckN9TWilC+4EmcfG8xCTDIUze8pVXRiNASjAi/nXWw+LnSVo7CHTu7jnGPZxeI4MOj3xCbFrKq296Kw91DoR6A969FGccVRUluHgMY8FXvLWL3/ACi8JEIMPDhzJzWiUqZALLYm4RepC3sD2Feb4viKVWUYwd3HRvk+7yMWKrRq1pTirJho5yNa5EZOLzIRceg4ow6IfVR+otW+jxStSe0X4pfaxZwsZ7J8OmJZsO0bMSS0Uh3PXK91rfHjUH/cp+j/ACdGjxTEU0ldNd6X+zmT/s7w5+ixUieUsSv+aEfpWiPEMHP9zXivwdKn/UE1pOmvJ2/Jzp/2bz/4eIwz/eZ4z8ip/WnKph5fLUj62+prh/UFB/NFr0YhiP2d47pCknmksR/Vgaeqcn8rT8Gh64xgp7u3ivwLf9k45SB+6OLkC/hsL9SwNgPOr7Co+Q5cSwSWk17ndwEkWFUQxMHLuhmlYeEkAABBuY1Jcgtve9tqzYmzhlg78/F9Dn1ZVK8u0mrWWi+772M8YxTZgskOe5IRRI5ZguzZV0sfSudRTkrxl7L0FUo32fsLycLlnfO6rELAeI5msBYabk+pFOhONKOVO4anCCtudTB8Pih1Hib7bakfdGy0qVRsU5OXcamxFKvcKMQGGieZssY295j7qg9z+g3PSjp0nPXl15IqpUhTV36dT1GGwQjQImw1JO7Md2P+nQVlxVZTtCHyr3fVmDO5Scpb/TuLMZ7VjsFdGahZKhCVCyVCiVCxlEtRpCm7lSPb1oZzylqNwBNZm77jLWKqEDRx9TTqdPmwJSM4ltPOm5rFJXORiIr02DIwcPEXgBTKjxMfEhBVj3tIuvzB+FdWhi406fZzjeL36mWpSz6nVbhkbIJI2dFIuCRzU/zJqv4hetFTgtGtHPRla/mjC4WdhPF2RIrOr5w0mZDmUqSApB6iyn51ysZgZYeMYbvVv7FSTjowKTVy3FolxfifiCC7AmRACrMpte76qRuqsK04WeVyfc+j8N+8XVV0l3m04plcRhSVDrDmL3bNkD3IOpGXre/l1ov0+aDqN2ds1raWvb6kVW0stu7cuTja8uZlRrx+GxAJLE5V8KksBex1A0INSODeeEW1aXP/ADsW66s2lsP/AL1H3AtkuCCpvIbILHqTpbvpWfsZbpddu7cZnj1CYh/CbkhSCrWubKylGNutg2b4VqwGIdOvFybt49RsXlaZ85m4PjFbJyJH7NGjOjjoyuosQa9D2UuWp6iGLoyjmUkem4Jg+TEAVyufpL+9mvsfIbWrnVpXk0InLO78hmSa1JbIoiU+J+faok2MSsNYbhTMbzXUfyx75+9/LHrr5dabJQoLNVfkt3+PMzTxPKnr38v8ncijCgKoCqNlXQDz7k9ybmuTiMZOtptFbJfzViFHW8tX1DCU0hVJIjiggmFMVVcynA0GBo1JMGzLKDtV2RLsrlDtUsiZmVyRUsiZmTlCpZEzMqSS3rQTnbYtRAVnGEqECxR9TTqcObAlI3K9vWmt2Biri9AMMyw2FOi8uop6s42LjvUU7su1jXBOKyYZjbxRn3k/uvZv1rq4DGSovTWPNCK1NS8T0rxJikLxiGYi9lkzROupORpEuV1J1ynvrXoLUMVHNZP6mJwV7TPJcR4hh4H5eJixWFboxVZ4W+46HM3yrnV+GYdvnH3Rsp8MqVo5qLUvPXzQbCYnDyfQ43DvfZWcwufwSAGudU4LJ/25J+xnqYKvT+aD9BxuCSZhJyAzDaRQjm1iNGW5tYn51lnw/HU45LO3RPT2ZldNKWZrUVbhiqGBjdc2W5OcEZTmUKT7oBJIA01NIlPExacovTu8ugPZRV+8r93vOJSRZUAAvqWBazMP6QzW++3lS1iMtF01zfounnz8C8l6mY6ay1mHJmf3eM38I13tpe/XTrTVXqRVlJ+pA8/C5HVTYuSD41ZA+hIGdHIDmwHiBB73r0dKjPEUoTcG21q015aPu5mqji501bdCZ9nTu7OB5mCMfFuY1vlTVwy2sr+y+7NL4k/2x9wjQRRECDIe8iOHbzXPuv4cu9Z8bWhhnkorday3f+AYzqVtaj06bIcwyi39q4k5Z3eQy2U20Pas8qXQJSBWpQZKhCVCFhjV5mSyNCU0SqSKyosTGi7VlZEXzvKr7XuJkBUkIlQgSJL69KZThfVgyYZ2sKeAtRYm9AMCwp1okgJMxiDfSlTnrYKKEJ4auMiNCmIw9hW+DshLV2c+BpInDxMVbuP0I2I8jWmjWlCV4uzKnFNWZ6OL2mikTlY2JSp0Jy50PmyHUfC/wrs0+JwatVRnjCcJZqbs/Q5mO/ZvgsSC+Dmyf0giWP8Ayk5l+fwrUqNKqs1NnTo8cr09K0VL2Z5qf9m3EICTAVbzhmMTepBy6/E0DoVY/KzoR4rgK2lSNvFX+n4Kjh47DscZ8W53/tmqXxC6luPCanOPuhqDiXHr6xSv/wCTCxD8wq1P+x7wv5CZ4ThX/wBF6nXwP/XHOuFwaj7UsaD8kkJ/Kq/TKW9KPojDVo8MhtUk/BflHqOHcMxQGbEtgh3EeHkAH42lH/rRrAYdayhH0OZVdG9qSfnb8GcZxDDIQTHFNKBlDLGAAt7hc7X0uSdL70itxHD4aKjTV7bJbepcKU5abI5E2JaU+JVC9EVQAP8AU+tefxPEa1aXxPTojVChGKHIoARWRvMrhrQ0VtSmNVmESbvUuC4hCAatxTBu0DaHtSnS6BKfUGykb0txaDTTKqiEqEJUISoQlQhpFuaKMbspuwztWnYVuLSPc0LdxiViRpc1ErkbsGlawqVJWQMVdi9ZhhqOO5plJa3Bm9BfGRdK1OQEUIjDa02EipCOKw+tSVTUpLQXigIa6kgjqCQfmKbSqtSumDKOh0k47i47WlJHZwrfmRf866EeIVofu9RfYxfIeh9rsTbVYj+Fh+jU+PFavNL+eYDoRIfbDE/YiH4XP/2pT4zW5JfzzL/TR6lf9w4px7wX7qj+96B8UrzW9vAvsIpiErSOf4jsx/qJPyHSsNXETm/ibY+MIpaIchw9xWebzIlrMNHDasUnqOQ1G1qGM2iNXGNCK0JqSF7AHjtVNBqRlWttVF2CrN3oswDiFBvVgmTEKFwTLUmYMHY0DpdAs5gxmgdOSCzIzkPY0OVkuiqosZRbCtUY2Qpu5iZulSTLiuYGhDGY1sKNaC27sDI1zWacszGJWRihLGIRpWimrIXJ6gZtTVthJaEjg0pkWBISmg1NJc9WEloCTDa02lPUGS0B4jC7U9zKiiQYarjMqSMnC61nnPVhpaB8NBrUhU1sU0NPhutFNkiEgFjS1INq4xKl9qGpC+oMXYBWcYWrWq4yad0U1cYRwa0xmpC2rGXiHSo4lqQFltvQh3KBqECLMavMU4hBKKK4DizYNWUSqIBhXrSqceYc2FY2FNASFSaAaEhXW9XEGTCTNYVKjsgYq7F6zDSwKiV2QaOgrWJFKAaNRjQUa2FPcVIrK3qONQoL/CmUnqDLYmIhGlOlIGJmCLWpFlyLmhF6VVety4GVW1KzMKw2uorUndCthZlsaCwxO4WF+lEmBJElj6il1Ic0XGXJgaSGQGoQMkvenRqcmA49AhFO3A2BtD2ocoSkCZSN6EO5VQhKhC857mpclhoCjStoKAzt0oZMOKBVQQ0i2FGkLbuBnOtIqu7sHBA6WEEhGtMprUGWwWU6U97AR3FqAYNmjFcxSsg4JDvTKXzAy2CTDSnPYCO4GM6ihQb2DTDSpUV0DF6i9ZxgWBulNpS5MCS5m5UuKc0VF2FxQBjEb39aNMW1YxLH1FKnDmgoy5MFSQyVCGkciijNopq4ZJAafGaYtxaN0ZRhoh6UNi1JgmiPrVWCUkVkPaq1LuMMbUYtCpNANNwrrVoqT0GKMWKk1kbuxyKqiBoBoadSWlwJlznQUyWxUQKbihQb2GW2PpRvYWtxWsg03FuKOn8yKlsGkGhrQxSFqAaNDUUe6F7MWIrK1Z2GooVRBpGuK1RlmQpqzAzJ1qmgoswDaqCGEe9GncW1YxJH1FLnT5oJSA0gMlQhKhDayEUaqNAuNwqyA06M0wHFo3RlEqFAp26UMmHFAaEMPAulEtgJPU1KdKqbtEqO4tWYaSoQZiGlaYK0RUtwc+4qSCiYi3FUi3sMPsaKWzFrcVrKOLU61a3IxqtYkUIpY0PA2lFECRmdetKqx5hQegKlBG4nsaOErMGSuMEVpFizpagaGJlKbVRdhhHvRp3FtWKkjvQygpEUrAGW1Z3FrcancqqISoQlQhpXIolJoppGucaPtWVkRJ96YyR2B1RY1HsKNbCnuYn2pdXYKG4CkDCVCDSbVrjshL3Az70Mtw47FRbiotyPYO+x9KuWwK3FayjSVCDdbBLFpNzS3uMWxuDc1cSpm5tqqp8pUNxes4wlQg0uwrXHYU9zE+3xqpFxAUIZuHerjuDLYYowAc+1Kq7BQAUgYSoQlQhKhCVCH//Z'	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)
-- [-] Make FastFood Number In Phone

-- [+] Functions
function cMarker(type, position, scale, color, facecamera, rotate)
    if facecamera == nil then facecamera = false end
    if rotate == nil then rotate = false end
    coord = vector3(position.x, position.y, position.z)
DrawMarker(
	type, 
	coord,
    0.0,
    0.0,
    0.0,
	0.0, 
	0.0, 
	0.0, 
	scale.a, 
	scale.b, 
	scale.c, 
	color.r, 
	color.g, 
	color.b, 
	150, 
	false, 
    facecamera,
    2,
	rotate
)
end

function OpenMenu()
    IsInvMenuOpen = true

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ff_chest', {
        title    = "FastFood Chest",
        align    = "center",
        elements = options
    }, function(data, menu)

    menu.close()
    IsInvMenuOpen = false

    if data.current.value == 'putstock' then
	OpenPutStocksMenu()
    elseif data.current.value == 'getstock' then
	OpenGetStocksMenu()
	end
    end, function(data, menu)
    menu.close()
    IsInvMenuOpen = false
    end)
end

function OpenVehMenu()
    IsVehMenuOpen = true

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ff_veh', {
        title    = "FastFood Vehicles",
        align    = "center",
        elements = VeHoptions
    }, function(data, menu)

    menu.close()
    IsVehMenuOpen = false

    if data.current.value == 'van' then
        driverHasCar = true
        spawnVehicle(Config.CarName)
    end
    end, function(data, menu)
    menu.close()
    IsVehMenuOpen = false
    end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_fastfood:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = 'FastFood Inventory',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = 'Quantity'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('~r~Quantity is wrong !')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_fastfood:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_fastfood:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = 'Inventory',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = 'Quantity'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('~r~Quantity is wrong !')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_fastfood:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end

function playerIsInside(playerCoords, coords, distance) 	
	local vecDiffrence = GetDistanceBetweenCoords(playerCoords, coords.x, coords.y, coords.z, false)
	return vecDiffrence < distance		
end

function loadCarEvent()
    isInMarker = false
	currentZone = 'none'
end

function spawnVehicle(carToSpawn)
	local vehicleModel = GetHashKey(carToSpawn)	
	RequestModel(vehicleModel)				
	while not HasModelLoaded(vehicleModel) do	
		Citizen.Wait(0)
        hasLoadedCar = false
	end
    hasLoadedCar = true
    loadCarEvent()
	currentCar = CreateVehicle(vehicleModel, Config.DeliveryCarSpawn.x, Config.DeliveryCarSpawn.y, Config.DeliveryCarSpawn.z, true, false)
    SetVehicleHasBeenOwnedByPlayer(currentCar,  true)	
	SetEntityAsMissionEntity(currentCar,  true,  true)														
	SetVehicleNumberPlateText(currentCar, "FastFood")								
	local id = NetworkGetNetworkIdFromEntity(currentCar)													
	SetNetworkIdCanMigrate(id, true)																																																
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), currentCar, -1)
    driverHasCar = true
	local props = {																							
		modEngine       = 0,
		modTransmission = 0,
		modSuspension   = 3,
		modTurbo        = true,																				
	}
	ESX.Game.SetVehicleProperties(currentCar, props)
	Wait(1000)																							
	currentPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function deleteCar()
    	local entity = GetVehiclePedIsIn(GetPlayerPed(-1), false)	
	    ESX.Game.DeleteVehicle(entity)			
        driverHasCar = false
        
end
-- [-] Functions
