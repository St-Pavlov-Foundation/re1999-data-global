module("modules.configs.excel2json.lua_activity187_blessing", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	lanternImg = 5,
	lanternImgBg = 6,
	blessing = 7,
	lanternRibbon = 4,
	lantern = 3,
	activityId = 1,
	bonus = 2
}
local var_0_2 = {
	"activityId",
	"bonus"
}
local var_0_3 = {
	blessing = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
