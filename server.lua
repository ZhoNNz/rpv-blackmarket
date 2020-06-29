
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("rpv-blackmarket:BuyItem")
AddEventHandler("rpv-blackmarket:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= totalBuyPrice then
		xPlayer.removeMoney(totalBuyPrice)
		xPlayer.addInventoryItem(itemName, amountToBuy)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = itemLabel .. amountToBuy .. 'x' ..totalBuyPrice.. '$ You Paid'})

	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money!'})

	end
end)
