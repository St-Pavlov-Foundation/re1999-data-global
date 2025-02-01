module("modules.configs.excel2json.lua_fight_debut_show", package.seeall)

slot1 = {
	audioId = 5,
	effect = 2,
	skinId = 1,
	effectHangPoint = 3,
	effectTime = 4
}
slot2 = {
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
