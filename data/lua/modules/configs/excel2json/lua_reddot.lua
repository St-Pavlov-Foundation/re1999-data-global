module("modules.configs.excel2json.lua_reddot", package.seeall)

slot1 = {
	canLoad = 4,
	isOnline = 3,
	parent = 2,
	style = 5,
	id = 1
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
