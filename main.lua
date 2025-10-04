local json = require("lib.json")
local mergebykey_lib = require("lib.mergebykey")

-- this so ugly oh well
os.execute(
	"curl -s -o ./tmp/warframe_data.lua 'https://wiki.warframe.com/index.php?title=Module:Warframes/data&action=raw'"
)
os.execute("curl -s -o ./tmp/relic_data.lua 'https://wiki.warframe.com/index.php?title=Module:Void/data&action=raw'")
os.execute(
	"curl -s -o ./tmp/warframe-items.json 'https://raw.githubusercontent.com/WFCD/warframe-items/master/data/json/Warframes.json'"
)

os.execute(
	"curl -s -o ./tmp/mission-items.json 'https://raw.githubusercontent.com/WFCD/warframe-items/refs/heads/master/data/json/Node.json'"
)

os.execute(
	"curl -s -o ./tmp/mission_wiki.lua 'https://wiki.warframe.com/index.php?title=Module:Missions/data&action=raw'"
)

function SortWarframeData()
	print("Sorting Warframe data")
	local warframes = require("tmp.warframe_data")
	local json_text = json.encode(warframes)

	local file = io.open("./data/warframes.json", "w")

	if file == nil then
		return
	end
	file:write(json_text)
	file:close()
end

function SortRelicData()
	print("Sorting Relic Data")
	local relic_data = require("relics")
	local relic_json = json.encode(relic_data)

	local relic_file = io.open("./data/relics.json", "w")

	if relic_file == nil then
		return
	end
	relic_file:write(relic_json)
	relic_file:close()
end

function SortMissionData()
	print("Sorting Mission Data")
	local wiki_missions = require("tmp.mission_wiki")
	local read_data = io.open("./tmp/mission-items.json", "r")
	local read_json = json.decode(read_data:read("*a"))

	for key, value in pairs(wiki_missions["MissionDetails"]) do
		if wiki_missions["MissionDetails"][key].InternalName then
			wiki_missions["MissionDetails"][key].uniqueName = wiki_missions["MissionDetails"][key].InternalName
			wiki_missions["MissionDetails"][key].InternalName = nil
		end
	end
	local result = mergebykey_lib.mergeByKey(wiki_missions["MissionDetails"], read_json, "uniqueName")

	-- MISSION TYPES
	local mission_types_file = io.open("./data/missiontypes.json", "w")
	if mission_types_file == nil then
		return
	end
	mission_types_file:write(json.encode(wiki_missions["MissionTypes"]))
	mission_types_file:close()

	-- MISSION DETAILS
	-- write to data file
	local file = io.open("./data/nodes.json", "w")
	if file == nil then
		return
	end
	file:write(json.encode(result))
	file:close()
end

-- Maybe Seperate these into other files in future lol
SortWarframeData()
SortRelicData()
SortMissionData()

print("data sorting completed")
