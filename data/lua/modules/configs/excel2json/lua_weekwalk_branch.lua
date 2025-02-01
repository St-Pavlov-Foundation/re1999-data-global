module("modules.configs.excel2json.lua_weekwalk_branch", package.seeall)

slot1 = {
	mapId = 2,
	name = 4,
	nodePath = 6,
	id = 1,
	finishNodeId = 3,
	handbookPath = 5
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
