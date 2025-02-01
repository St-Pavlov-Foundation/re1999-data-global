module("modules.configs.excel2json.lua_rouge_layer_rule", package.seeall)

slot1 = {
	version = 1
}
slot2 = {}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
