local wibox         = require("wibox")

batterywidget = wibox.widget.textbox()
batterywidget.WARNING_CUTOFF = 15
batterywidget.loaded_text = "00% ~00:00"

batterywidget.load_values = function()
  fh = assert(io.popen("acpi", "r"))
  text = fh:read("*l")
  fh.close()
  useful_text = text:gsub(".*: ",""):gsub("remaining", ""):gsub(":[0-9]* ", ""):gsub("%%, ", "%% ~")
  view_text = useful_text:gsub("^[a-zA-Z]*, ", "")

  batterywidget.battery_status = useful_text:gsub(",.*", "")
  batterywidget.loaded_text = view_text
  batterywidget.battery_percent = view_text:gsub("%%.*", "")
end

batterywidget.load_values()

batterywidget.load_timer = timer({ timeout = 5 })
batterywidget.load_timer:connect_signal("timeout",    
  function()
    batterywidget.load_values()
  end    
) 
batterywidget.load_timer:start()

batterywidget.flashed = false

batterywidget.refresh_timer = timer({ timeout = 1 })
batterywidget.refresh_timer:connect_signal("timeout",
  function()
    color_text = function(input_text, color)
      return "<span color = \"" .. color .."\">" .. input_text .. "</span>"
    end

    battery_percent = batterywidget.battery_percent
    battery_status = batterywidget.battery_status
    colored_text = batterywidget.loaded_text

    if battery_status == "Discharging" then
      if tonumber(battery_percent) < batterywidget.WARNING_CUTOFF then
        batterywidget.flashed = not batterywidget.flashed
        if batterywidget.flashed then
          colored_text = color_text(colored_text, "red")
        end
      end
    else
      colored_text = color_text(colored_text, "green")
    end

    batterywidget:set_markup(" | " .. colored_text  .. " | ")    
  end
)
batterywidget.refresh_timer:start()

return batterywidget
