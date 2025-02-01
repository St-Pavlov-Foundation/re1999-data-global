module("modules.configs.excel2json.lua_activity108_story", package.seeall)

slot1 = {
	id = 1,
	story = 3,
	bind = 4,
	params = 2
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
