module("modules.configs.excel2json.lua_fishing_map_building", package.seeall)

local var_0_0 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = var_0_0.json_parse(arg_1_0)
end

function var_0_0.json_parse(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		iter_2_1.isFishingBuilding = true

		table.insert(var_2_0, iter_2_1)

		local var_2_2 = var_2_1[iter_2_1.mapId]

		if not var_2_2 then
			var_2_2 = {}
			var_2_1[iter_2_1.mapId] = var_2_2
		end

		var_2_2[iter_2_1.uid] = iter_2_1
	end

	return var_2_0, var_2_1
end

return var_0_0
