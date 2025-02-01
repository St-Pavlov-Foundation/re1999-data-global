module("modules.configs.excel2json.lua_critter_catalogue", package.seeall)

slot1 = {
	parentId = 3,
	name = 4,
	type = 2,
	id = 1,
	baseCard = 5
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
