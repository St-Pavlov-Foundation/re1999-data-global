module("modules.configs.excel2json.lua_rouge_entrust", package.seeall)

slot1 = {
	interactive = 4,
	param = 3,
	incompleteEffect = 5,
	type = 2,
	id = 1
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
