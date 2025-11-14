local primary = require("tmp.primary")
function SortWeaponData()
	print("Sorting Weapon Data")
	os.execute(
		"curl -s -o ./tmp/primary.json 'https://raw.githubusercontent.com/WFCD/warframe-items/master/data/json/Primary.json'"
	)
	os.execute(
		"curl -s -o ./tmp/secondary.json 'https://raw.githubusercontent.com/WFCD/warframe-items/master/data/json/Secondary.json'"
	)
	os.execute(
		"curl -s -o ./tmp/melee.json 'https://raw.githubusercontent.com/WFCD/warframe-items/master/data/json/Melee.json'"
	)
	os.execute( -- CONTAINS SOME EXALTED WEAPONS
		"curl -s -o ./tmp/misc.json 'https://raw.githubusercontent.com/WFCD/warframe-items/master/data/json/Misc.json'"
	)
	os.execute(
		"curl -s -o ./tmp/primary.lua 'https://wiki.warframe.com/index.php?title=Module:Weapons/data/primary&action=raw'"
	)
	os.execute(
		"curl -s -o ./tmp/secondary.lua 'https://wiki.warframe.com/index.php?title=Module:Weapons/data/secondary&action=raw'"
	)
	os.execute(
		"curl -s -o ./tmp/melee.lua 'https://wiki.warframe.com/index.php?title=Module:Weapons/data/melee&action=raw'"
	)
	-- Holy
	local primary_wiki_data = require("tmp.primary")
	local secondary_wiki_data = require("tmp.secondary")
	local melee_wiki_data = require("tmp.melee")

	local pd = io.open("./tmp/primary.json", "r")
	local sd = io.open("./tmp/secondary.json", "r")
	local md = io.open("./tmp/melee.json", "r")
	local miscd = io.open("./tmp/misc.json", "r")

	local primary_data = json.decode(pd:read("*a"))
	local secondary_data = json.decode(sd:read("*a"))
	local melee_data = json.decode(md:read("*a"))
	local misc_data = json.decode(miscd:read("*a"))

	-- YEEEEEPPPPPPPPPPPP
	for key, value in pairs(primary_wiki_data) do
		for key2, table in pairs(primary_wiki_data[key]) do
			if type(table) == "table" then
				for k, v in pairs(table) do
					if not v.FireRate then
						goto continue
					end
					if v.FireRate == math.huge then
						v.FireRate = 0
					end
				end
				::continue::
			end
		end

		primary_wiki_data[key].name = primary_wiki_data[key].Name
		if primary_wiki_data[key].InternalName then
			primary_wiki_data[key].uniqueName = primary_wiki_data[key].InternalName
		end
	end

	for key, value in pairs(secondary_wiki_data) do
		--print(key)
		secondary_wiki_data[key].name = secondary_wiki_data[key].Name
		if secondary_wiki_data[key].InternalName then
			secondary_wiki_data[key].uniqueName = secondary_wiki_data[key].InternalName
		end
	end

	for key, value in pairs(melee_wiki_data) do
		melee_wiki_data[key].name = melee_wiki_data[key].Name
		if melee_wiki_data[key].InternalName then
			melee_wiki_data[key].uniqueName = melee_wiki_data[key].InternalName
		end
	end

	local primary_result = mergebykey_lib.mergeTableByKey(primary_wiki_data, primary_data, "uniqueName")
	local secondary_result = mergebykey_lib.mergeTableByKey(secondary_data, secondary_wiki_data, "uniqueName")
	local melee_result = mergebykey_lib.mergeTableByKey(melee_wiki_data, melee_data, "uniqueName")

	local primary_file = io.open("./data/primary.json", "w")

	if primary_file == nil then
		return
	end
	primary_file:write(json.encode(primary_result))
	primary_file:close()
	local secondary_file = io.open("./data/secondary.json", "w")

	if secondary_file == nil then
		return
	end
	secondary_file:write(json.encode(secondary_result))
	secondary_file:close()
	local melee_file = io.open("./data/melee.json", "w")

	if melee_file == nil then
		return
	end
	melee_file:write(json.encode(melee_result))
	melee_file:close()
end

return SortWeaponData
