module("modules.configs.excel2json.lua_skill_behavior", package.seeall)

slot1 = {
	audioId = 5,
	effect = 3,
	id = 1,
	type = 2,
	effectHangPoint = 4,
	dec_Type = 6,
	dec = 7
}
slot2 = {
	"id"
}
slot3 = {
	dec = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
