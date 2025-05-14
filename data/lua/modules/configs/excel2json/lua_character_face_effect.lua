module("modules.configs.excel2json.lua_character_face_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	node = 4,
	face = 3,
	heroResName = 1,
	effectCompName = 2
}
local var_0_2 = {
	"heroResName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
