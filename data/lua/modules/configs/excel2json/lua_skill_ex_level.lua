module("modules.configs.excel2json.lua_skill_ex_level", package.seeall)

slot1 = {
	skillEx = 8,
	passiveSkill = 9,
	desc = 5,
	skillGroup1 = 6,
	requirement = 4,
	skillGroup2 = 7,
	skillLevel = 2,
	heroId = 1,
	consume2 = 10,
	consume = 3
}
slot2 = {
	"heroId",
	"skillLevel"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
