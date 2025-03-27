module("modules.configs.excel2json.lua_turnback_sign_in", package.seeall)

slot1 = {
	bonus = 3,
	name = 5,
	characterId = 4,
	turnbackId = 1,
	content = 6,
	day = 2
}
slot2 = {
	"turnbackId",
	"day"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
