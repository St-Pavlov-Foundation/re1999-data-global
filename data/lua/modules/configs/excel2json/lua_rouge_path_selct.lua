module("modules.configs.excel2json.lua_rouge_path_selct", package.seeall)

slot1 = {
	id = 1,
	focusPos = 3,
	mapRes = 2
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
