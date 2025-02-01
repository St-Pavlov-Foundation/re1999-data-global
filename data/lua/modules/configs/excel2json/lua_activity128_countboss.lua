module("modules.configs.excel2json.lua_activity128_countboss", package.seeall)

slot1 = {
	battleId = 1,
	monsterId = 2,
	maxPoints = 4,
	finalMonsterId = 3
}
slot2 = {
	"battleId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
