module("modules.configs.excel2json.lua_toast", package.seeall)

slot1 = {
	audioId = 4,
	tips = 2,
	notMerge = 5,
	notShow = 6,
	id = 1,
	icon = 3
}
slot2 = {
	"id"
}
slot3 = {
	tips = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
