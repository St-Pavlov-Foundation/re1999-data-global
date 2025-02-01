module("modules.configs.excel2json.lua_hero_upgrade", package.seeall)

slot1 = {
	id = 1,
	heroId = 4,
	options = 3,
	type = 2
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
