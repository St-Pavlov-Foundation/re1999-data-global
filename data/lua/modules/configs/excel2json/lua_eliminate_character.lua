module("modules.configs.excel2json.lua_eliminate_character", package.seeall)

slot1 = {
	resPic = 4,
	name = 2,
	hp = 3,
	characterId = 1,
	skillName1 = 5,
	skillName2 = 6,
	defaultUnlock = 7
}
slot2 = {
	"characterId"
}
slot3 = {
	skillName1 = 2,
	name = 1,
	skillName2 = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
