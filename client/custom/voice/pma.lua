if GetResourceState('pma-voice') ~= 'started' and Config.Voice == 'auto' or Config.Voice ~= 'pma-voice' and Config.Voice ~= 'auto' then return end

OverrideRange = function ()
    exports['pma-voice']:overrideProximityRange(Config.Range, false)
end

ClearCustomRange = function ()
    exports['pma-voice']:clearProximityOverride()
end
