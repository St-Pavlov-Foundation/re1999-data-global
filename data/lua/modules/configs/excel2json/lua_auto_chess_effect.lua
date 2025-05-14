module("modules.configs.excel2json.lua_auto_chess_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tag = 2,
	subtag = 3,
	nameDown = 5,
	type = 6,
	target = 9,
	offset = 11,
	nameUp = 4,
	duration = 12,
	loop = 8,
	playertype = 7,
	soundId = 13,
	id = 1,
	position = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
