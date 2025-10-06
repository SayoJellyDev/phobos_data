local mergeKey = {}

-- lets do it myself
function mergeKey.mergeTableByKey(t1, t2, key)
	--convert data to arrays instead of tables with key names

	local table1 = {}
	local table2 = {}

	for _, v in pairs(t1) do
		--print("weapon name: ", v[key])
		table1[#table1 + 1] = v
	end
	for _, v in pairs(t2) do
		table2[#table2 + 1] = v
	end

	for _, mt1 in pairs(table1) do
		for _, mt2 in pairs(table2) do
			if mt1[key] == mt2[key] then
				for k, item in pairs(mt2) do
					mt1[k] = item
				end
				mt2.completed = true
				mt2.notfound = false
			else
				mt2.notfound = true
			end
		end
	end

	for _, notfound in pairs(table2) do
		if not notfound.notfound then
		  goto continue
    end
    if notfound.completed then
      goto continue
    end

    table1[#table1 + 1] = notfound

		::continue::
	end

  return table1
	-- combine tables whilst checking key
end

return mergeKey
