module("modules.configs.excel2json.lua_trade_support_bonus", package.seeall)

slot1 = {
	id = 1,
	needTask = 3,
	bonus = 2
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
