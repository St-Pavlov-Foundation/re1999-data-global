module("modules.configs.excel2json.lua_version_activity_puzzle_question", package.seeall)

slot1 = {
	id = 1,
	text = 3,
	answer = 4,
	tittle = 2
}
slot2 = {
	"id"
}
slot3 = {
	text = 2,
	answer = 3,
	tittle = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
