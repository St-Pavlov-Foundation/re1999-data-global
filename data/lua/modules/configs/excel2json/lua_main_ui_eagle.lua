module("modules.configs.excel2json.lua_main_ui_eagle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	animName = 5,
	location = 8,
	odds_nextstep = 2,
	isoutline = 9,
	playfadeAnim = 10,
	times = 7,
	loop = 6,
	isSpineAnim = 4,
	id = 1,
	option_nextstep = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
