module("modules.configs.excel2json.lua_activity159_critter", package.seeall)

slot1 = {
	name = 1,
	startPos = 4,
	res = 2,
	anim = 3,
	scale = 5
}
slot2 = {
	"name"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
