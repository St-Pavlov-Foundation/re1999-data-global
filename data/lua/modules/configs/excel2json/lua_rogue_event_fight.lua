module("modules.configs.excel2json.lua_rogue_event_fight", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heartChange5 = 8,
	heartChange4 = 7,
	attrChange1 = 9,
	type = 3,
	oldtemplate = 14,
	attrChange2 = 10,
	episode = 2,
	attrChange3 = 11,
	attrChange5 = 13,
	attrChange4 = 12,
	newtemplate = 15,
	heartChange1 = 4,
	id = 1,
	heartChange2 = 5,
	isChangeScene = 16,
	heartChange3 = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
