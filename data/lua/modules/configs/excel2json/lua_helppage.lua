module("modules.configs.excel2json.lua_helppage", package.seeall)

slot1 = {
	text = 4,
	icon = 5,
	unlockGuideId = 7,
	type = 3,
	id = 1,
	title = 2,
	isCn = 8,
	iconText = 6
}
slot2 = {
	"id"
}
slot3 = {
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
