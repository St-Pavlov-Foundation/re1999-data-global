module("modules.configs.excel2json.lua_achievement_group", package.seeall)

slot1 = {
	uiListParam = 6,
	name = 4,
	desc = 5,
	category = 2,
	id = 1,
	unLockAchievement = 8,
	uiPlayerParam = 7,
	order = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
