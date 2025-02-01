module("modules.configs.excel2json.lua_rogue_collection_drop", package.seeall)

slot1 = {
	groupId = 2,
	id = 1,
	weights = 3
}
slot2 = {
	"id",
	"groupId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
