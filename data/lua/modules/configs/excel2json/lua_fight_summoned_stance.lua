module("modules.configs.excel2json.lua_fight_summoned_stance", package.seeall)

slot1 = {
	pos3 = 4,
	pos1 = 2,
	pos2 = 3,
	id = 1,
	pos4 = 5
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
