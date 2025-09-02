-- ====================|| VARIABLES || ==================== --

local megaphoneSubmix = nil
local usingMegaphone = false
local prop = nil

-- ====================|| INIT || ==================== --

CreateThread(function()
    megaphoneSubmix = CreateAudioSubmix('Megaphone')
    SetAudioSubmixEffectRadioFx(megaphoneSubmix, 0)
    SetAudioSubmixEffectParamInt(megaphoneSubmix, 0, GetHashKey('default'), 1)
    SetAudioSubmixOutputVolumes(megaphoneSubmix, 0, 1.0, 0.25, 0.0, 0.0, 1.0, 1.0)
    AddAudioSubmixOutput(megaphoneSubmix, 0)
end)

-- ====================|| FUNCTIONS || ==================== --
function GetAnimType(isItem)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) and not isItem  then
        return Config.AnimConfiguration.invehicle
    else
        return Config.AnimConfiguration.outvehicle
    end
end

function UseMegaphone(isItem)
    if not megaphoneSubmix then return end
    if not Config.CanUseVehicleMegaphone() and not HasItem(Config.ItemName, 1) then return Notify(Locale('cannot-use'), 'error') end

    local anim = GetAnimType(isItem)
    local ped = PlayerPedId()

    if not DoesEntityExist(ped) then return end

    RequestAnimDict(anim.dict)
    while not HasAnimDictLoaded(anim.dict) do
        Wait(100)
    end

    if anim.prop then
        RequestModel(anim.prop.name)
        while not HasModelLoaded(anim.prop.name) do
            Wait(100)
        end

        prop = CreateObject(anim.prop.name, 0, 0, 0, true, true, true)
        AttachEntityToEntity(prop, ped, anim.prop.bone, anim.prop.placement[1], anim.prop.placement[2], anim.prop.placement[3], anim.prop.placement[4], anim.prop.placement[5], anim.prop.placement[6], true, true, false, true, 1, true)
    end

    CreateThread(function ()
        while usingMegaphone do
            TaskPlayAnim(ped, anim.dict, anim.anim, 8.0, -8.0, -1, 49, 0, false, false, false)
        end
    end)

    TriggerServerEvent('skys_megaphone:server:SetMegaphone', true)
end

exports('UseMegaphone', UseMegaphone)

function ClearMegaphone()
    usingMegaphone = false
    ClearPedTasks(PlayerPedId())
    if prop and DoesEntityExist(prop) then DeleteObject(prop) end
    TriggerServerEvent('skys_megaphone:server:SetMegaphone', false)
end

exports('ClearMegaphone', ClearMegaphone)

-- ====================|| EVENTS || ==================== --

RegisterNetEvent('skys_megaphone:client:ToggleMegaphone')
AddEventHandler('skys_megaphone:client:ToggleMegaphone', function()
    UseMegaphone(true)
end)

RegisterNetEvent('skys_megaphone:client:SetMegaphone')
AddEventHandler('skys_megaphone:client:SetMegaphone', function(isActive, source)
    if not megaphoneSubmix then return end

    if isActive then
        MumbleSetVolumeOverrideByServerId(source, Config.MegaphoneVolume)
        MumbleSetSubmixForServerId(source, megaphoneSubmix)
        OverrideRange()
    else
        MumbleSetSubmixForServerId(source, -1)
        MumbleSetVolumeOverrideByServerId(source, -1.0)
        CrearCustomRange()
        MumbleClearVoiceTargetPlayers(1.0)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    TriggerServerEvent('skys_megaphone:server:SetMegaphone', false)
end)

-- ====================|| COMMAND || ==================== --

RegisterCommand('+megaphone', function()
    usingMegaphone = true
    UseMegaphone()
end, false)

RegisterCommand('-megaphone', function()
    usingMegaphone = false
    ClearMegaphone()
end, false)

RegisterKeyMapping('+megaphone', Locale('command-description'), '', '')
RegisterKeyMapping('-megaphone', Locale('command-description'), '', '')
