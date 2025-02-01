module("modules.configs.excel2json.lua_rogue_score", package.seeall)

slot1 = {
	reward = 3,
	score = 2,
	special = 5,
	id = 1,
	stage = 4
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
