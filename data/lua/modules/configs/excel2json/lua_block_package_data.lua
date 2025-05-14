module("modules.configs.excel2json.lua_block_package_data", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	packageId = 3,
	blockId = 2,
	mainRes = 5,
	defineId = 1,
	order = 4
}
local var_0_2 = {
	"blockId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict, var_0_0.packageDict = var_0_0.json_parse(arg_1_0)
end

function var_0_0.json_parse(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if not var_2_2[iter_2_1.id] then
			var_2_2[iter_2_1.id] = {}
		end

		local var_2_3 = var_2_2[iter_2_1.id]

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.infos) do
			iter_2_3.packageId = iter_2_1.id
			iter_2_3.packageOrder = iter_2_2

			table.insert(var_2_0, iter_2_3)

			var_2_1[iter_2_3.blockId] = iter_2_3

			table.insert(var_2_3, iter_2_3)
		end
	end

	return var_2_0, var_2_1, var_2_2
end

return var_0_0
