module("modules.configs.excel2json.lua_activity128_enhance", package.seeall)

slot1 = {
	sort = 3,
	desc = 5,
	characterId = 2,
	activityId = 1,
	exchangeSkills = 4
}
slot2 = {
	"activityId",
	"characterId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
