module("modules.configs.excel2json.lua_turnback_recommend", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 10,
	limitCount = 12,
	turnbackId = 1,
	relateActId = 11,
	prepose = 5,
	offlineTime = 8,
	constTime = 6,
	openId = 9,
	onlineTime = 7,
	id = 2,
	icon = 3,
	order = 4
}
local var_0_2 = {
	"turnbackId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
