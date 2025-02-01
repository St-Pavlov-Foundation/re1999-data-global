module("modules.configs.excel2json.lua_skill_passive_level", package.seeall)

slot1 = {
	skillGroup = 5,
	heroId = 1,
	skillPassive = 3,
	uiFilterSkill = 4,
	skillLevel = 2
}
slot2 = {
	"heroId",
	"skillLevel"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
