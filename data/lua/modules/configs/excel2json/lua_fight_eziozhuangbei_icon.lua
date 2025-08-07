module("modules.configs.excel2json.lua_fight_eziozhuangbei_icon", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	weaponId = 1,
	name = 5,
	firsticon = 3,
	type = 2,
	secondicon = 4
}
local var_0_2 = {
	"weaponId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
