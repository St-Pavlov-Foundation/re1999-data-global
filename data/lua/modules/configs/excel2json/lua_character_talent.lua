module("modules.configs.excel2json.lua_character_talent", package.seeall)

slot1 = {
	requirement = 5,
	heroId = 1,
	consume = 6,
	exclusive = 4,
	talentMould = 3,
	talentId = 2
}
slot2 = {
	"heroId",
	"talentId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
