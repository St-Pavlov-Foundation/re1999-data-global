module("modules.configs.excel2json.lua_summon_equip_detail", package.seeall)

slot1 = {
	texture = 4,
	texturePoster = 5,
	equipId = 3,
	location = 6,
	id = 1,
	poolId = 2
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
