module("modules.configs.excel2json.lua_fight_effect", package.seeall)

slot1 = {
	career3 = 4,
	career5 = 6,
	career2 = 3,
	career6 = 7,
	id = 1,
	career1 = 2,
	career4 = 5
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
