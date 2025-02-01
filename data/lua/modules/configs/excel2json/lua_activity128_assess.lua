module("modules.configs.excel2json.lua_activity128_assess", package.seeall)

slot1 = {
	spriteName = 3,
	needPointBoss1 = 4,
	mainBg = 8,
	needPointBoss2 = 5,
	layer4Assess = 9,
	battleIconBg = 7,
	strLevel = 2,
	needPointBoss3 = 6,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
