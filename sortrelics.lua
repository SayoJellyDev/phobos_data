function SortRelicData()
	os.execute(
		"curl -s -o ./tmp/relic_data.lua 'https://wiki.warframe.com/index.php?title=Module:Void/data&action=raw'"
	)
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

return SortRelicData
