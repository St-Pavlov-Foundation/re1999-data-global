module("modules.configs.excel2json.lua_guide_mask", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	uiOffset1 = 2,
	uiInfo1 = 3,
	uiOffset2 = 5,
	id = 1,
	goPath1 = 4,
	goPath4 = 13,
	uiInfo3 = 9,
	uiInfo4 = 12,
	goPath3 = 10,
	goPath2 = 7,
	uiInfo2 = 6,
	uiOffset3 = 8,
	uiOffset4 = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
