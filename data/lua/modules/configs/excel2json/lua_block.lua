module("modules.configs.excel2json.lua_block", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	prefabPath = 2,
	mainRes = 4,
	category = 5,
	resourceIds = 3,
	defineId = 1
}
local var_0_2 = {
	"defineId"
}
local var_0_3 = {}
local var_0_4 = {
	"blockType",
	"waterType"
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.confgData = arg_1_0
	var_0_0.configList, var_0_0.configDict = var_0_0.json_parse(arg_1_0)
	var_0_0.propertyList, var_0_0.propertyDict = var_0_0.json_property(arg_1_0, var_0_4)
end

function var_0_0.json_parse(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		table.insert(var_2_0, iter_2_1)

		var_2_1[iter_2_1.defineId] = iter_2_1

		if iter_2_1.category == cjson.null then
			iter_2_1.category = nil
		end

		local var_2_2 = {}

		iter_2_1.resIdCountDict = var_2_2

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.resourceIds) do
			var_2_2[iter_2_3] = (var_2_2[iter_2_3] or 0) + 1
		end
	end

	return var_2_0, var_2_1
end

function var_0_0.json_property(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_2 = {}
		local var_3_3 = {}

		var_3_0[iter_3_1] = var_3_2
		var_3_1[iter_3_1] = var_3_3

		for iter_3_2, iter_3_3 in ipairs(arg_3_0) do
			local var_3_4 = iter_3_3[iter_3_1]

			if var_3_4 and not var_3_3[var_3_4] then
				var_3_3[var_3_4] = var_3_4

				table.insert(var_3_2, var_3_4)
			end
		end

		logNormal(string.format("lua_block.json_property [%s]:%s,", iter_3_1, table.concat(var_3_2, ",")))
	end

	return var_3_0, var_3_1
end

return var_0_0
