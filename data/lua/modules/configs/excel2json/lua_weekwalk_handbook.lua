module("modules.configs.excel2json.lua_weekwalk_handbook", package.seeall)

slot1 = {
	text = 6,
	positionOffset = 5,
	type = 3,
	id = 1,
	position = 4,
	branchId = 2
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
