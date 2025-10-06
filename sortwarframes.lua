function SortWarframeData()
	-- this so ugly oh well
	os.execute(
		"curl -s -o ./tmp/warframe_data.lua 'https://wiki.warframe.com/index.php?title=Module:Warframes/data&action=raw'"
	)
	os.execute(
		"curl -s -o ./tmp/warframe-items.json 'https://raw.githubusercontent.com/WFCD/warframe-items/master/data/json/Warframes.json'"
	)
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

return SortWarframeData
