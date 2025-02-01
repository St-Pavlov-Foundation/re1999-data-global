module("modules.configs.excel2json.lua_rouge_short_voice", package.seeall)

slot1 = {
	audioId = 2,
	id = 1,
	groupId = 3,
	weight = 5,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
