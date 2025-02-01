module("modules.configs.excel2json.lua_activity130_dialog", package.seeall)

slot1 = {
	param = 4,
	single = 6,
	option_param = 5,
	type = 3,
	id = 1,
	stepId = 2,
	content = 8,
	speaker = 7
}
slot2 = {
	"id",
	"stepId"
}
slot3 = {
	speaker = 1,
	content = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
