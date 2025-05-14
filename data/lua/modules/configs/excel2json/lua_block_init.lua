module("modules.configs.excel2json.lua_block_init", package.seeall)

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
	var_0_0.configList, var_0_0.configDict, var_0_0.poscfgDict = var_0_0.json_parse(arg_1_0)
end

function var_0_0.json_parse(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = {}

	if arg_2_0.infos then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.infos) do
			local var_2_3 = {
				blockId = iter_2_1.blockId,
				defineId = iter_2_1.defineId,
				mainRes = iter_2_1.mainRes
			}

			var_2_3.packageId = -1
			var_2_3.order = -1

			table.insert(var_2_0, var_2_3)

			var_2_1[var_2_3.blockId] = var_2_3

			if not var_2_2[iter_2_1.x] then
				var_2_2[iter_2_1.x] = {}
			end

			var_2_2[iter_2_1.x][iter_2_1.y] = iter_2_1
		end
	end

	return var_2_0, var_2_1, var_2_2
end

return var_0_0
