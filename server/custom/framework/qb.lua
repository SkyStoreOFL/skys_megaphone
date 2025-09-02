if GetResourceState('qb-core') ~= 'started' and Config.Framework == 'auto' or Config.Framework ~= 'qb-core' and Config.Framework ~= 'auto' then return end

QBCore = exports["qb-core"]:GetCoreObject()

RegisterNewItem = QBCore.Functions.CreateUseableItem
