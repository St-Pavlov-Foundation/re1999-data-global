module("modules.configs.excel2json.lua_battle_dialog", package.seeall)

slot1 = {
	param = 3,
	icon = 7,
	canRepeat = 4,
	random = 6,
	delay = 11,
	text = 9,
	insideRepeat = 5,
	audioId = 8,
	id = 2,
	code = 1,
	tipsDir = 10
}
slot2 = {
	"code",
	"id"
}
slot3 = {
	text = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
