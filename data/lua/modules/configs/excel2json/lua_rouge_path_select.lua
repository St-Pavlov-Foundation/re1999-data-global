module("modules.configs.excel2json.lua_rouge_path_select", package.seeall)

slot1 = {
	startPos = 7,
	name = 3,
	focusMapPos = 5,
	endPos = 8,
	id = 1,
	version = 2,
	focusCameraSize = 6,
	mapRes = 4
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
