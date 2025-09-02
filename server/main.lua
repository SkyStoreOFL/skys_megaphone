
RegisterNewItem(Config.ItemName, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    TriggerClientEvent('skys_megaphone:client:ToggleMegaphone', source)
end)

RegisterServerEvent("skys_megaphone:server:SetMegaphone")
AddEventHandler("skys_megaphone:server:SetMegaphone", function(isActive)
    TriggerClientEvent('skys_megaphone:client:SetMegaphone', -1, isActive, source)
end)
