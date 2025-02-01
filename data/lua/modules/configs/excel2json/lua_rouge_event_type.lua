module("modules.configs.excel2json.lua_rouge_event_type", package.seeall)

slot1 = {
	name = 3,
	version = 2,
	type = 1
}
slot2 = {
	"type"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
