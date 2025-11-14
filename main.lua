json = require("lib.json")
mergebykey_lib = require("lib.mergebykey")
local SortWeaponData = require("sortweapons")
local SortMissionData = require("sortmissions")
local SortRelicData = require("sortrelics")
local SortWarframeData = require("sortwarframes")

-- Maybe Seperate these into other files in future lol
SortWarframeData()
SortRelicData()
SortMissionData()
SortWeaponData()

print("data sorting completed")
