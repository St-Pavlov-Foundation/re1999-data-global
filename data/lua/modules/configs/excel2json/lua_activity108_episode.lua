module("modules.configs.excel2json.lua_activity108_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	period = 5,
	mapId = 2,
	actpoint = 6,
	epilogue = 8,
	day = 4,
	showBoss = 10,
	res = 3,
	id = 1,
	showExhibits = 9,
	preface = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	epilogue = 2,
	preface = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
