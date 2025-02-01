module("modules.configs.excel2json.lua_skin_monster_scale", package.seeall)

slot1 = {
	effectName = 3,
	monsterId = 2,
	scale = 4,
	skillId = 1
}
slot2 = {
	"skillId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
