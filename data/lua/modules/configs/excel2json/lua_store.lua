module("modules.configs.excel2json.lua_store", package.seeall)

slot1 = {
	id = 1,
	refreshCost = 3,
	autoRefreshTime = 2,
	needClearStore = 4
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
