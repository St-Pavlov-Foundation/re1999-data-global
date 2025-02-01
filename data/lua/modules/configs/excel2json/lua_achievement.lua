module("modules.configs.excel2json.lua_achievement", package.seeall)

slot1 = {
	startTime = 8,
	name = 5,
	endTime = 9,
	groupId = 3,
	uiPlayerParam = 6,
	category = 2,
	id = 1,
	isMask = 7,
	order = 4
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
