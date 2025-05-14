module("modules.configs.excel2json.lua_soldier_chess", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 8,
	name = 2,
	defaultPower = 6,
	type = 4,
	sell = 7,
	skillId = 12,
	resZoom = 11,
	formationDisplays = 3,
	resPic = 9,
	id = 1,
	resModel = 10,
	level = 5
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
