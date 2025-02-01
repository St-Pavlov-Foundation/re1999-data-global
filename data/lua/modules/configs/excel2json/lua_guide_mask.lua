module("modules.configs.excel2json.lua_guide_mask", package.seeall)

slot1 = {
	uiOffset1 = 2,
	uiInfo1 = 3,
	uiOffset2 = 5,
	id = 1,
	goPath1 = 4,
	goPath4 = 13,
	uiInfo3 = 9,
	uiInfo4 = 12,
	goPath3 = 10,
	goPath2 = 7,
	uiInfo2 = 6,
	uiOffset3 = 8,
	uiOffset4 = 11
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
