module("modules.configs.excel2json.lua_tip_dialog", package.seeall)

slot1 = {
	stepId = 2,
	content = 6,
	audio = 7,
	type = 3,
	id = 1,
	icon = 5,
	pos = 4
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
