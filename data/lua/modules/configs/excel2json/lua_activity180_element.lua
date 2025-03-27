module("modules.configs.excel2json.lua_activity180_element", package.seeall)

slot1 = {
	episodeId = 4,
	name = 2,
	id = 1,
	sequence = 5,
	desc = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
