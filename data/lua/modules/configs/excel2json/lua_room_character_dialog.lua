module("modules.configs.excel2json.lua_room_character_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	selectIds = 7,
	relateContent = 6,
	speaker = 3,
	stepId = 2,
	content = 4,
	critteremoji = 5,
	speakerType = 8,
	dialogId = 1,
	nextStepId = 9
}
local var_0_2 = {
	"dialogId",
	"stepId"
}
local var_0_3 = {
	speaker = 1,
	relateContent = 3,
	content = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
