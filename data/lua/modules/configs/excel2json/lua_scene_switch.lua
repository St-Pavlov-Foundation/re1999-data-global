module("modules.configs.excel2json.lua_scene_switch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eggSwitchTime = 8,
	initReportId = 9,
	itemId = 3,
	storyId = 12,
	reportSwitchTime = 10,
	previewIcon = 5,
	eggList = 7,
	resName = 6,
	previews = 11,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
