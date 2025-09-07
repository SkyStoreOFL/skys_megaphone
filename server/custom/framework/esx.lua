if GetResourceState('es_extended') ~= 'started' and Config.Framework == 'auto' or Config.Framework ~= 'es_extended' and Config.Framework ~= 'auto' then return end

ESX = exports["es_extended"]:getSharedObject()

RegisterNewItem = ESX.RegisterUsableItem
