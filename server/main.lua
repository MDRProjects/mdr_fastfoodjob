ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- [+] Make FastFood Number In Phone
TriggerEvent('esx_phone:registerNumber', 'fastfood', 'alert_fastfood', true, true)
TriggerEvent('esx_society:registerSociety', 'fastfood', 'FastFood', 'society_fastfood', 'society_fastfood', 'society_fastfood', {type = 'public'})
-- [-] Make FastFood Number In Phone

-- [+] Make Items
ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification('You eated a bread')
end)

ESX.RegisterUsableItem('sausage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sausage', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification('You eated a sausage')
end)

ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('burger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 700000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification('You eated a burger')
end)

ESX.RegisterUsableItem('drink', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drink', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 700000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification('You drinked a drink')
end)

ESX.RegisterUsableItem('fries', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fries', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification('You eated fries')
end)
ESX.RegisterUsableItem('packaged_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('packaged_burger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 2000000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
    xPlayer.showNotification('You eated a burger')
    xPlayer.showNotification('You drinked a drink')
    xPlayer.showNotification('You eated a potato')
end)
-- [-] Make Items

-- [+] Change Duty
RegisterServerEvent('esx_fastfood:changeDuty')
AddEventHandler('esx_fastfood:changeDuty', function(job)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == 'fastfood' and xPlayer.job.grade == 0 then
        xPlayer.setJob('offdutyfastfood', 0)
        xPlayer.showNotification('~r~ You went off-duty !', true, false, 120)
	elseif xPlayer.job.name == 'fastfood' and xPlayer.job.grade == 1 then
        xPlayer.setJob('offdutyfastfood', 1)
        xPlayer.showNotification('~r~ You went off-duty !', true, false, 120)
    elseif xPlayer.job.name == 'fastfood' and xPlayer.job.grade == 2 then
        xPlayer.setJob('offdutyfastfood', 2)
        xPlayer.showNotification('~r~ You went off-duty !', true, false, 120)
    elseif xPlayer.job.name == 'fastfood' and xPlayer.job.grade == 3 then
        xPlayer.setJob('offdutyfastfood', 3)
        xPlayer.showNotification('~r~ You went off-duty !', true, false, 120)
    end

	if xPlayer.job.name == 'offdutyfastfood' and xPlayer.job.grade == 0 then
        xPlayer.setJob('fastfood', 0)
        xPlayer.showNotification('~g~ You went on-duty !', true, false, 120)
    elseif xPlayer.job.name == 'offdutyfastfood' and xPlayer.job.grade == 1 then
        xPlayer.setJob('fastfood', 1)
        xPlayer.showNotification('~g~ You went on-duty !', true, false, 120)
    elseif xPlayer.job.name == 'offdutyfastfood' and xPlayer.job.grade == 2 then
        xPlayer.setJob('fastfood', 2)
        xPlayer.showNotification('~g~ You went on-duty !', true, false, 120)
    elseif xPlayer.job.name == 'offdutyfastfood' and xPlayer.job.grade == 3 then
        xPlayer.setJob('fastfood', 3)
        xPlayer.showNotification('~g~ You went on-duty !', true, false, 120)
    end
end)
-- [-] Change Duty

-- [+] Make Markers Usable
RegisterServerEvent('esx_fastfood:cookedDrink')
AddEventHandler('esx_fastfood:cookedDrink', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem('drink', 1) then
        xPlayer.addInventoryItem('drink', 1)
        xPlayer.showNotification('~g~You poured a drink', true, false, 120)
    else
        xPlayer.showNotification('~r~Inventory is full !', true, false, 120)
    end
end)
RegisterServerEvent('esx_fastfood:cookedBurger')
AddEventHandler('esx_fastfood:cookedBurger', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem, xItem2 = xPlayer.getInventoryItem('bread'), xPlayer.getInventoryItem('sausage')
      if xItem.count > 0 and xItem2.count > 0 then
    if xPlayer.canCarryItem('burger', 1) then
        xPlayer.removeInventoryItem('bread', 1)
        xPlayer.removeInventoryItem('sausage', 1)
        xPlayer.addInventoryItem('burger', 1)
        xPlayer.showNotification('~g~You cooked a burger', true, false, 120)
    else
        xPlayer.showNotification('~r~Inventory is full !', true, false, 120)
    end
else
    xPlayer.showNotification('~r~You need bread and sausage !', true, false, 120)
end
end)
RegisterServerEvent('esx_fastfood:cookedFries')
AddEventHandler('esx_fastfood:cookedFries', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem('fries', 1) then
        xPlayer.addInventoryItem('fries', 1)
        xPlayer.showNotification('~g~You get fries', true, false, 120)
    else
        xPlayer.showNotification('~r~Inventory is full !', true, false, 120)
    end
end)
RegisterServerEvent('esx_fastfood:cookedPackage')
AddEventHandler('esx_fastfood:cookedPackage', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem, xItem2, xItem3 = xPlayer.getInventoryItem('burger'), xPlayer.getInventoryItem('drink'), xPlayer.getInventoryItem('fries')
      if xItem.count > 0 and xItem2.count > 0 and xItem3.count > 0 then
    if xPlayer.canCarryItem('packaged_burger', 1) then
        xPlayer.removeInventoryItem('burger', 1)
		xPlayer.removeInventoryItem('drink', 1)
		xPlayer.removeInventoryItem('fries', 1)
        xPlayer.addInventoryItem('packaged_burger', 1)
        xPlayer.showNotification('~g~You made a package', true, false, 120)
    else
        xPlayer.showNotification('~r~Inventory is full !', true, false, 120)
    end
else
    xPlayer.showNotification('~r~You need a burger and a drink and fries !', true, false, 120)
end
end)

RegisterServerEvent('esx_fastfood:getStockItem')
AddEventHandler('esx_fastfood:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fastfood', function(inventory)
		local item = inventory.getItem(itemName)

		if count > 0 and item.count >= count then

			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, item.label))
			else
				xPlayer.showNotification(_U('player_cannot_hold'))
			end
		else
			xPlayer.showNotification(_U('invalid_quantity'))
		end
	end)
end)
ESX.RegisterServerCallback('esx_fastfood:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fastfood', function(inventory)
		cb(inventory.items)
	end)
end)
RegisterServerEvent('esx_fastfood:putStockItems')
AddEventHandler('esx_fastfood:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fastfood', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			xPlayer.showNotification(_U('invalid_quantity'))
		end

		xPlayer.showNotification(_U('have_deposited', count, item.label))
	end)
end)
ESX.RegisterServerCallback('esx_fastfood:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)
-- [-] Make Markers Usable
