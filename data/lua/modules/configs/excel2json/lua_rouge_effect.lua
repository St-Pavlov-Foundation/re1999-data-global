module("modules.configs.excel2json.lua_rouge_effect", package.seeall)

slot1 = {
	tips = 2,
	typeParam = 5,
	type = 4,
	id = 1,
	version = 3
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
