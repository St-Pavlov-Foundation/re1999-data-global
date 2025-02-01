module("modules.configs.excel2json.lua_activity126_dreamland", package.seeall)

slot1 = {
	indicator = 5,
	num = 6,
	dreamCards = 7,
	battleIds = 8,
	id = 1,
	cardSkill = 4,
	activityId = 2,
	desc = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
