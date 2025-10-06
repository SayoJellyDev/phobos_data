function SortMissionData()
	-- Mission Nodes from wiki (includes game types!)
	os.execute(
		"curl -s -o ./tmp/mission_wiki.lua 'https://wiki.warframe.com/index.php?title=Module:Missions/data&action=raw'"
	)
	-- Mission Nodes from warframe items
	os.execute(
		"curl -s -o ./tmp/mission-items.json 'https://raw.githubusercontent.com/WFCD/warframe-items/refs/heads/master/data/json/Node.json'"
	)
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

	local result = mergebykey_lib.mergeTableByKey(wiki_missions["MissionDetails"], read_json, "uniqueName")

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

return SortMissionData
