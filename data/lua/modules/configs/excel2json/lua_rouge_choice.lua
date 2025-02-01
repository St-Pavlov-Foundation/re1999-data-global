module("modules.configs.excel2json.lua_rouge_choice", package.seeall)

slot1 = {
	interactive = 8,
	display = 9,
	selectedDesc = 7,
	unlockParam = 4,
	title = 5,
	desc = 6,
	unlockType = 3,
	id = 1,
	version = 2
}
slot2 = {
	"id"
}
slot3 = {
	title = 1,
	selectedDesc = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
