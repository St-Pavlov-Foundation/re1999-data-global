module("modules.configs.excel2json.lua_activity108_dialog", package.seeall)

slot1 = {
	param = 4,
	stepId = 2,
	option_param = 5,
	type = 3,
	id = 1,
	result = 6,
	content = 7
}
slot2 = {
	"id",
	"stepId"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
