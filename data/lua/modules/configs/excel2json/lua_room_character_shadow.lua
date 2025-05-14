module("modules.configs.excel2json.lua_room_character_shadow", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	animName = 2,
	shadow = 3,
	skinId = 1
}
local var_0_2 = {
	"skinId",
	"animName"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
