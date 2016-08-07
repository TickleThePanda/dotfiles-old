local module_path = (...):match ("(.+/)[^/]+$") or ""

package.loaded.batterywidget = nil

local batterywidget = {
    batterywidget = require(module_path .. "battery.batterywidget")
}

return batterywidget
