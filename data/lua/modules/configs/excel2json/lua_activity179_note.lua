module("modules.configs.excel2json.lua_activity179_note", package.seeall)

slot1 = {
	musicId = 2,
	time = 5,
	eventName = 4,
	id = 1,
	buttonId = 3
}
slot2 = {
	"id",
	"musicId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
