module("modules.configs.excel2json.lua_activity166_talent", package.seeall)

slot1 = {
	activityId = 1,
	name = 3,
	baseSkillIds = 6,
	baseSkillIds2 = 7,
	sortIndex = 8,
	icon = 5,
	talentId = 2,
	nameEn = 4
}
slot2 = {
	"activityId",
	"talentId"
}
slot3 = {
	nameEn = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
