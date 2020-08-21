ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('blackmarket', function(source, rawCommand)
	TriggerClientEvent("rpv-blackmarket:Erisim",source)
    Wait(200)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message durum"><b>BLACKMARKET STATUS :</b> Komut devreye girdi</div>',
        args = { user, msg }
    })
end)

RegisterCommand('hedef', function(source, rawCommand)

	TriggerClientEvent("rpv-blackmarket:hedef",source)
    Wait(200)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message durum"><b>HEDEF YOLDA :</b> Birazdan gelecek</div>',
        args = { user, msg }
    })

end)



RegisterServerEvent("rpv-blackmarket:BuyItem")
AddEventHandler("rpv-blackmarket:BuyItem", function(amountToBuy,totalBuyPrice,itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= totalBuyPrice then
		xPlayer.removeMoney(totalBuyPrice)
		xPlayer.addInventoryItem(itemName, amountToBuy)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = itemLabel .. amountToBuy .. 'x' ..totalBuyPrice.. '$ Ödedin'})

	else

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok!'})

	end
end)
