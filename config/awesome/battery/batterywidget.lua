local wibox         = require("wibox")

batterywidget = wibox.widget.textbox()
batterywidget.WARNING_CUTOFF = 15
batterywidget.loaded_text = "00% ~00:00"

batterywidget.get_text = function()
  fh = assert(io.popen("acpi | cut -d ' ' -f 4,5 | cut -d ':' -f -2 -", "r"))
  text = fh:read("*l"):gsub(",", ""):gsub(" ", " ~")
  fh.close()
  return text
end

batterywidget.loaded_text = batterywidget.get_text()

batterywidget.load_timer = timer({ timeout = 5 })
batterywidget.load_timer:connect_signal("timeout",    
  function()
    batterywidget.loaded_text = batterywidget.get_text()
  end    
)    
batterywidget.load_timer:start()

batterywidget.flashed = false

batterywidget.refresh_timer = timer({ timeout = 1})
batterywidget.refresh_timer:connect_signal("timeout",
  function()
    battery_percent = batterywidget.loaded_text:gsub("%%.*", "")

    coloured_text = batterywidget.loaded_text
    if tonumber(battery_percent) < batterywidget.WARNING_CUTOFF then
        batterywidget.flashed = not batterywidget.flashed
	if batterywidget.flashed then
           coloured_text = "<span color=\"red\">" .. coloured_text .. "</span>"
        end
    end

    batterywidget:set_markup(" | " .. coloured_text  .. " | ")    
  end
)
batterywidget.refresh_timer:start()

return batterywidget
