module("modules.configs.excel2json.lua_eliminate_chess", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 5,
	name = 2,
	defaultPower = 4,
	resPic = 6,
	rare = 3,
	chessId = 1,
	skillId = 8,
	resModel = 7,
	defaultUnlock = 9
}
local var_0_2 = {
	"chessId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
