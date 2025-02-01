module("modules.configs.excel2json.lua_critter_skin", package.seeall)

slot1 = {
	handEffects = 5,
	spine = 4,
	largeIcon = 3,
	id = 1,
	headIcon = 2
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
