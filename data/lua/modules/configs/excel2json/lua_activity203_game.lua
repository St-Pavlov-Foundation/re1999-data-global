module("modules.configs.excel2json.lua_activity203_game", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	battleGroup = 3,
	gameTarget = 4,
	battlePic = 2,
	battleTime = 7,
	loseTarget = 5,
	skill = 6,
	battledesc = 8,
	targetDesc = 9,
	gameId = 1
}
local var_0_2 = {
	"gameId"
}
local var_0_3 = {
	targetDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
