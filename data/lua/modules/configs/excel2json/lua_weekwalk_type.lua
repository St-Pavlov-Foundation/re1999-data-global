module("modules.configs.excel2json.lua_weekwalk_type", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroCd = 2,
	isRefresh = 5,
	starNum = 7,
	type = 1,
	showDetail = 6,
	canResetLayer = 4,
	star = 3
}
local var_0_2 = {
	"type"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
