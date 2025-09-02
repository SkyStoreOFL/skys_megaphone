# 📢 Sky's Megaphone

<p align="center">
  <img src="https://img.shields.io/github/license/SkyStoreOFL/skys_megaphone?style=for-the-badge&color=blue" alt="License">
  <img src="https://img.shields.io/github/stars/SkyStoreOFL/skys_megaphone?style=for-the-badge&color=yellow" alt="Stars">
  <img src="https://img.shields.io/github/forks/SkyStoreOFL/skys_megaphone?style=for-the-badge&color=green" alt="Forks">
  <img src="https://img.shields.io/github/issues/SkyStoreOFL/skys_megaphone?style=for-the-badge&color=red" alt="Issues">
</p>

<p align="center">
  <strong>🎯 A realistic and professional megaphone system for FiveM</strong><br>
  Compatible with QBCore and PMA-Voice
</p>

---

## ✨ Features

-   🚔 **Emergency vehicle compatibility** - Works with police and emergency vehicles (class 18 and 15)
-   🎙️ **Realistic audio** - Configurable audio effects with custom submix
-   🎭 **Detailed animations** - Different animations for inside and outside vehicle
-   🔧 **Highly configurable** - Easy configuration of volume, effects and restrictions
-   🌍 **Multi-language** - Localization system included (Spanish included)
-   🎯 **Automatic framework detection** - Compatible with QBCore
-   📱 **Optimized** - Clean and efficient code

## 📋 Requirements

-   **FiveM Server** (Latest version recommended)
-   **PMA-Voice** or compatible voice system
-   **QBCore Framework** (optional, automatic detection)

## 🚀 Installation

1. **Download the resource**

    ```bash
    git clone https://github.com/SkyStoreOFL/skys_megaphone.git
    ```

2. **Place the resource in your resources folder**

    ```
    resources/[standalone]/skys_megaphone/
    ```

3. **Add to server.cfg**

    ```cfg
    ensure skys_megaphone
    ```

4. **Restart the server**

5. **QBCore Setup (if using QBCore framework)**

    Add the following item to your QBCore items configuration:

    ```lua
    megaphone                    = { name = 'megaphone', label = 'Megáfono', weight = 100, type = 'item', image = 'megaphone.png', unique = false, useable = true, shouldClose = true, description = 'Un megáfono para hacer anuncios' },
    ```

    The inventory image is located at `install/megaphone.png` - copy this file to your inventory images folder.

## ⚙️ Configuration

The `Config.lua` file allows you to fully customize the megaphone behavior:

### 📊 Main Configuration

```lua
-- Volume level for the megaphone (0.0 to 1.0)
Config.MegaphoneVolume = 0.90

-- Range of the megaphone in meters
Config.Range = 30.0

-- Language for the resource ('es' for Spanish, 'en' for English, etc.)
Config.Locale = 'es'

-- Framework detection ('auto' for automatic detection, 'qb' for QBCore)
Config.Framework = 'auto'
```

### 🎵 Audio Effects

```lua
-- Audio submix configuration for megaphone effects
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
```

### 🎭 Animation Configuration

```lua
Config.AnimConfiguration = {
    -- Animations when inside a vehicle
    invehicle = {
        dict = 'anim@rifle_megaphone',          -- Animation dictionary
        anim = 'rifle_holding_megaphone',       -- Animation name
        prop = {
            name = 'prop_megaphone_01',         -- Prop model name
            bone = 60309,                       -- Bone to attach to
            placement = { 0.0480, 0.0190, 0.0160, -94.8944, -2.3093, -10.9030 }
        }
    },
    -- Animations when outside a vehicle
    outvehicle = {
        dict = 'random@arrests',                -- Animation dictionary
        anim = 'generic_radio_enter',           -- Animation name
        prop = {
            name = 'prop_cs_hand_radio',        -- Prop model name
            bone = 28422,                       -- Bone to attach to
            placement = { 0.0750, 0.0230, -0.0230, -90.0000, 0.0, -59.9999 }
        }
    }
}
```

### 🚗 Vehicle Restrictions

By default, the megaphone only works with:

-   **Class 18**: Emergency vehicles
-   **Class 15**: Helicopters
-   **Maximum distance**: 5 meters from vehicle

## 🎮 Usage

### For Players

1. Enter a compatible emergency vehicle
2. Use the megaphone command or item (depending on server configuration)
3. Speak into your microphone to transmit through the megaphone
4. Use the command/item again to deactivate

### For Developers

#### Available Exports

```lua
-- Activate megaphone (from item or command)
exports['skys_megaphone']:UseMegaphone(isItem)

-- Deactivate megaphone and clear animations/props
exports['skys_megaphone']:ClearMegaphone()

-- Check if player can use megaphone (returns boolean)
local canUse = Config.CanUseVehicleMegaphone()
if canUse then
    -- Player can use the megaphone
end

-- Get localized text
local text = Locale('cannot-use')
```

#### Usage Examples

```lua
-- Example: Custom item usage
RegisterNetEvent('myresource:useMegaphone')
AddEventHandler('myresource:useMegaphone', function()
    if Config.CanUseVehicleMegaphone() then
        exports['skys_megaphone']:UseMegaphone(true)
    else
        -- Show error message
        print(Locale('cannot-use'))
    end
end)

-- Example: Custom command
RegisterCommand('togglemegaphone', function()
    exports['skys_megaphone']:UseMegaphone(false)
end)

-- Example: Stop megaphone usage
RegisterCommand('stopmegaphone', function()
    exports['skys_megaphone']:ClearMegaphone()
end)
```

#### Events

```lua
-- Client Events
TriggerEvent('skys_megaphone:client:ToggleMegaphone')
TriggerEvent('skys_megaphone:client:SetMegaphone', isActive, source)

-- Server Events
TriggerServerEvent('skys_megaphone:server:SetMegaphone', isActive)
```

## 📁 Project Structure

```
skys_megaphone/
├── 📄 Config.lua              # Main configuration
├── 📄 fxmanifest.lua         # Resource manifest
├── 📄 README.md              # This file
├── 📄 LICENSE                # Project license
├── 📁 client/                # Client-side scripts
│   ├── 📄 main.lua          # Main client logic
│   └── 📁 custom/           # Customizations
│       ├── 📁 framework/    # Framework integrations
│       │   └── 📄 qb.lua   # QBCore integration
│       └── 📁 voice/        # Voice integrations
│           └── 📄 pma.lua  # PMA-Voice integration
├── 📁 server/               # Server-side scripts
│   ├── 📄 main.lua         # Main server logic
│   └── 📁 custom/          # Server customizations
│       └── 📁 framework/   # Framework integrations
│           └── 📄 qb.lua  # QBCore integration
└── 📁 locales/             # Language files
    └── 📄 es.lua          # Spanish translations
```

## 🔧 Customization

### Adding New Languages

1. Create a new file in `locales/` (e.g: `en.lua`)
2. Add the translations:

```lua
Locales['en'] = {
    ['cannot-use'] = 'You cannot use the megaphone in this vehicle.',
}
```

3. Change `Config.Locale = 'en'` in the configuration file

### Modifying Compatible Vehicles

Edit the `Config.CanUseVehicleMegaphone` function in `Config.lua`:

```lua
Config.CanUseVehicleMegaphone = function ()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, true)
    local vehicleClass = GetVehicleClass(vehicle)

    -- Add more vehicle classes here
    local allowedClasses = {18, 15, 16} -- Emergency, Helicopters, Planes

    for _, class in ipairs(allowedClasses) do
        if vehicleClass == class then
            return true
        end
    end

    return false
end
```

## 🐛 Troubleshooting

### Megaphone not working

-   ✅ Verify you're in a compatible vehicle
-   ✅ Make sure PMA-Voice is working
-   ✅ Check console for errors

### No audio heard

-   ✅ Check volume configuration in `Config.lua`
-   ✅ Make sure your microphone is working
-   ✅ Check PMA-Voice configuration

### Framework errors

-   ✅ Verify QBCore is installed (if you use it)
-   ✅ Make sure the resource starts after the framework

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is under the MIT License. See the `LICENSE` file for more details.

## 🙏 Credits

-   **Developed by**: [SkyStore](https://github.com/SkyStoreOFL)
-   **Inspired by**: Real-life megaphone systems
-   **Special thanks**: To the FiveM community

---

<p align="center">
  <strong>⭐ If you like this project, don't forget to give it a star! ⭐</strong>
</p>

<p align="center">
  <a href="https://github.com/SkyStoreOFL">🔗 More SkyStore projects</a> •
  <a href="https://github.com/SkyStoreOFL/skys_megaphone/issues">🐛 Report Bug</a> •
  <a href="https://github.com/SkyStoreOFL/skys_megaphone/issues">💡 Request Feature</a>
</p>
