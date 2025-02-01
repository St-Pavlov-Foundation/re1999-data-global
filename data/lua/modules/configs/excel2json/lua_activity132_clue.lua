module("modules.configs.excel2json.lua_activity132_clue", package.seeall)

slot1 = {
	contents = 4,
	name = 3,
	pos = 5,
	clueId = 2,
	smallBg = 6,
	activityId = 1
}
slot2 = {
	"activityId",
	"clueId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
