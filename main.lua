local json = require("json")

os.execute("curl -s -o data.lua 'https://wiki.warframe.com/index.php?title=Module:Warframes/data&action=raw'")
local warframes = dofile("data.lua")

local json_text = json.encode(warframes)

-- 5. Save to file
local file = io.open("./warframe_data.json", "w")
file:write(json_text)
file:close()

print("Conversion complete! JSON saved as warframe_data.json")
