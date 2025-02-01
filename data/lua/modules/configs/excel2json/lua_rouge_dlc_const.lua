module("modules.configs.excel2json.lua_rouge_dlc_const", package.seeall)

slot1 = {
	value = 2,
	id = 1,
	value2 = 3
}
slot2 = {
	"id"
}
slot3 = {
	value2 = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
