local json = require("lib.json")

os.execute("curl -s -o ./tmp/warframe_data.lua 'https://wiki.warframe.com/index.php?title=Module:Warframes/data&action=raw'")
os.execute("curl -s -o ./tmp/relic_data.lua 'https://wiki.warframe.com/index.php?title=Module:Void/data&action=raw'")

local warframes = require("tmp.warframe_data")
local relic_data = require("relics")

local json_text = json.encode(warframes)
local relic_json = json.encode(relic_data)

local relic_file = io.open("./data/relics.json", "w")
relic_file:write(relic_json)
relic_file:close()

local file = io.open("./data/warframes.json", "w")
file:write(json_text)
file:close()

print("Completed, Data is stored in ./data/ :bongo:")
