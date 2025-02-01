module("modules.configs.excel2json.lua_skin_special_act", package.seeall)

slot1 = {
	loop = 2,
	probability = 4,
	condition = 3,
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
