-- I'll be real i have no clue what this is for because i forgor lol, oh i think it is to seperate the lua script from the data
local file = io.open("./tmp/relic_data.lua", "r")
local text = file:read("*a")
file:close()

local positions = {}
for pos in text:gmatch("()RelicData%s*=") do
	table.insert(positions, pos)
end

if #positions < 2 then
	error("Did not find a second RelicData definition")
end

local start_pos = positions[2]

local brace_start = text:find("{", start_pos)
if not brace_start then
	error("Could not find opening brace for second RelicData")
end

local level, brace_end = 0, nil
for i = brace_start, #text do
	local c = text:sub(i, i)
	if c == "{" then
		level = level + 1
	elseif c == "}" then
		level = level - 1
		if level == 0 then
			brace_end = i
			break
		end
	end
end

if not brace_end then
	error("Could not find closing brace for second RelicData")
end

local relicdata_str = text:sub(start_pos, brace_end)

local relicdata = assert(load("return " .. relicdata_str:match("{.*}")))()

return relicdata
