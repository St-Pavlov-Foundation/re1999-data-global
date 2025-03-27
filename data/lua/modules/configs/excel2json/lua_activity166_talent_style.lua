module("modules.configs.excel2json.lua_activity166_talent_style", package.seeall)

slot1 = {
	needStar = 3,
	slot = 6,
	skillId2 = 5,
	skillId = 4,
	talentId = 1,
	level = 2
}
slot2 = {
	"talentId",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
