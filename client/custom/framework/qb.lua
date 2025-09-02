if GetResourceState('qb-core') ~= 'started' and Config.Framework == 'auto' or Config.Framework ~= 'qb-core' and Config.Framework ~= 'auto' then return end

QBCore = exports["qb-core"]:GetCoreObject()

Notify = QBCore.Functions.Notify
HasItem = QBCore.Functions.HasItem
