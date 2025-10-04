local mergeKey = {}

function mergeKey.mergeByKey(t1, t2, key)
	local merged = {}
	local index = {}

	-- first copy t1 into merged
	for _, v in ipairs(t1) do
		local k = v[key]
		local copy = {}
		for kk, vv in pairs(v) do
			copy[kk] = vv
		end
		merged[#merged + 1] = copy
		index[k] = copy
	end

	-- merge t2
	for _, v in ipairs(t2) do
		local k = v[key]
		if index[k] then
			-- merge fields into existing row
			for kk, vv in pairs(v) do
				if kk ~= key then
					index[k][kk] = vv
				end
			end
		else
			-- add new row
			local copy = {}
			for kk, vv in pairs(v) do
				copy[kk] = vv
			end
			merged[#merged + 1] = copy
			index[k] = copy
		end
	end

	return merged
end

return mergeKey
