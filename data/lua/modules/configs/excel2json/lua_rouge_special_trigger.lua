module("modules.configs.excel2json.lua_rouge_special_trigger", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eventCorrectWeight = 4,
	unlockTask = 8,
	reasonRange = 3,
	name = 2,
	eventGroupCorrectWeight = 5,
	shopGroupCorrectWeight = 6,
	inPictorial = 9,
	dropGroupCorrectWeight = 7,
	id = 1,
	isShow = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
