module("modules.configs.excel2json.lua_activity174_bot_level", package.seeall)

slot1 = {
	upWin = 3,
	downLost = 4,
	rank = 2,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
