module("modules.configs.excel2json.lua_rouge_genius_branchlight", package.seeall)

slot1 = {
	lightname = 3,
	talent = 2,
	id = 1,
	pos = 4,
	order = 5
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
