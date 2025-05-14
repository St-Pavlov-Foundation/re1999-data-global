module("modules.configs.excel2json.lua_mail", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jump = 13,
	needShowToast = 7,
	sender = 3,
	type = 2,
	attachment = 6,
	title = 4,
	addressee = 8,
	copy = 9,
	specialTag = 11,
	content = 5,
	image = 14,
	jumpTitle = 12,
	id = 1,
	icon = 10,
	senderType = 15
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 3,
	title = 2,
	jumpTitle = 6,
	copy = 5,
	sender = 1,
	addressee = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
