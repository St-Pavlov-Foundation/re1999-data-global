module("modules.configs.excel2json.lua_scene_eggs", package.seeall)

slot1 = {
	parallel = 5,
	actionClass = 3,
	id = 1,
	actionParams = 4,
	path = 2
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
