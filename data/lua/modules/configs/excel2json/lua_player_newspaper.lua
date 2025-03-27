module("modules.configs.excel2json.lua_player_newspaper", package.seeall)

slot1 = {
	name = 3,
	type = 2,
	id = 1,
	displayPriority = 5,
	nameEn = 4
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
