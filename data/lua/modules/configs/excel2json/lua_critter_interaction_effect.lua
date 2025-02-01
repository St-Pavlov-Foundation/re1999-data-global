module("modules.configs.excel2json.lua_critter_interaction_effect", package.seeall)

slot1 = {
	animName = 5,
	effectKey = 6,
	point = 3,
	skinId = 1,
	id = 2,
	effectRes = 4
}
slot2 = {
	"skinId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
