if GetResourceState('es_extended') ~= 'started' and Config.Framework == 'auto' or Config.Framework ~= 'es_extended' and Config.Framework ~= 'auto' then return end

ESX = exports["es_extended"]:getSharedObject()

Notify = ESX.ShowNotification
HasItem = function (item, count)
    local itemData = ESX.SearchInventory(item)
    return itemData and itemData.count >= (count or 1)
end
