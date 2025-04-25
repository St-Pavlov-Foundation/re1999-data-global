module("modules.configs.excel2json.lua_challenge_condition", package.seeall)

slot1 = {
	decs1 = 4,
	decs2 = 6,
	id = 1,
	type = 2,
	value = 3,
	rule = 5
}
slot2 = {
	"id"
}
slot3 = {
	decs2 = 2,
	decs1 = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
