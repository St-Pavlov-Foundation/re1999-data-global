module("modules.configs.excel2json.lua_production_part", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	productionLines = 4,
	name = 2,
	audio = 6,
	cameraParam = 5,
	id = 1,
	changeAudio = 7,
	nameEn = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
