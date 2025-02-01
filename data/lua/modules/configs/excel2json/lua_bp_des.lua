module("modules.configs.excel2json.lua_bp_des", package.seeall)

slot1 = {
	iconType = 4,
	bpId = 2,
	type = 3,
	id = 1,
	icon = 6,
	items = 5,
	des = 7
}
slot2 = {
	"id"
}
slot3 = {
	des = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
