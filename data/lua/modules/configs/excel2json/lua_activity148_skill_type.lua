module("modules.configs.excel2json.lua_activity148_skill_type", package.seeall)

slot1 = {
	skillInfoDesc = 4,
	skillIcon = 5,
	skillValueDesc = 3,
	skillNameEn = 6,
	id = 1,
	skillName = 2
}
slot2 = {
	"id"
}
slot3 = {
	skillInfoDesc = 3,
	skillName = 1,
	skillValueDesc = 2,
	skillNameEn = 5,
	skillIcon = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
