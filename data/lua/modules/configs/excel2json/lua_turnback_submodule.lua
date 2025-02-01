module("modules.configs.excel2json.lua_turnback_submodule", package.seeall)

slot1 = {
	jumpId = 7,
	name = 3,
	reddotId = 8,
	actDesc = 5,
	id = 1,
	turnbackId = 2,
	showInPopup = 6,
	nameEn = 4
}
slot2 = {
	"id"
}
slot3 = {
	actDesc = 3,
	name = 1,
	nameEn = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
