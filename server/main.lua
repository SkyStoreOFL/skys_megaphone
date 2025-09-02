
RegisterNewItem(Config.ItemName, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    TriggerClientEvent('skys_megaphone:client:ToggleMegaphone', source)
end)

RegisterNetEvent('skys_megaphone:server:SetMegaphone', function(isActive)
    TriggerClientEvent('skys_megaphone:server:SetMegaphone', -1, isActive, source)
end)
