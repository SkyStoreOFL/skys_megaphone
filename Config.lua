Config = Config or {}

-- Volume level for the megaphone (0.0 to 1.0)
Config.MegaphoneVolume = 0.90

-- Range of the megaphone in meters
Config.Range = 30.0

-- Language for the resource ('es' for Spanish, 'en' for English, etc.)
Config.Locale = 'en'

-- Framework detection ('auto' for automatic detection, 'qb' for QBCore)
Config.Framework = 'auto'

-- Voice detection ('auto' for automatic detection, 'pma-voice' for PMA-Voice)
Config.Voice = 'auto'

-- Item name for the megaphone
Config.ItemName = 'megaphone'

-- Audio submix configuration for megaphone effects
---@type table<number, number>
Config.SubmixData = {
    [`default`] = 1,           -- Default submix value
    [`freq_low`] = 300.0,      -- Low frequency cutoff
    [`freq_hi`] = 5000.0,      -- High frequency cutoff
    [`rm_mod_freq`] = 0.0,     -- Ring modulation frequency
    [`rm_mix`] = 0.2,          -- Ring modulation mix
    [`fudge`] = 0.0,           -- Fudge factor for audio processing
    [`o_freq_lo`] = 550.0,     -- Output low frequency
    [`o_freq_hi`] = 0.0,       -- Output high frequency
}

-- Function to determine if a player can use the vehicle megaphone
-- By default, only works with emergency vehicles (class 18) and helicopters (class 15)
-- and when the player is within 5 meters of the vehicle
Config.CanUseVehicleMegaphone = function ()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, true)
    local vehicleClass = GetVehicleClass(vehicle)

    local vehCoords = GetEntityCoords(vehicle)
    local playerCoords = GetEntityCoords(playerPed)

    return (vehicleClass == 18 or vehicleClass == 15) and (IsPedInAnyVehicle(playerPed, false) or #(vehCoords - playerCoords) < 3.0)
end

-- Animation configuration for different scenarios
Config.AnimConfiguration = {
    -- Animations when outside a vehicle
    outvehicle = {
        dict = 'anim@rifle_megaphone',          -- Animation dictionary
        anim = 'rifle_holding_megaphone',       -- Animation name
        prop = {
            name = 'prop_megaphone_01',         -- Prop model name
            bone = 60309,                       -- Bone to attach to
            placement = { 0.0480, 0.0190, 0.0160, -94.8944, -2.3093, -10.9030 } -- X, Y, Z, RX, RY, RZ
        }
    },
    -- Animations when inside a vehicle
    invehicle = {
        dict = 'random@arrests',                -- Animation dictionary
	    anim = 'generic_radio_enter',           -- Animation name
        prop = {
            name = 'prop_cs_hand_radio',        -- Prop model name
            bone = 28422,                       -- Bone to attach to
            placement = { 0.0750, 0.0230, -0.0230, -90.0000, 0.0, -59.9999 } -- X, Y, Z, RX, RY, RZ
        }
    }
}

--- Get the correct text according to Config.Locale
--- @param locale string The locale key to retrieve
--- @param ... string[] Additional parameters for string formatting
--- @return string The localized string or error message if locale doesn't exist
function Locale(locale, ...)
    if not Locales[Config.Locale][locale] then return 'LOCALE ' .. locale .. ' DOES NOT EXIST' end
    return string.format( Locales[Config.Locale][locale], ...)
end
