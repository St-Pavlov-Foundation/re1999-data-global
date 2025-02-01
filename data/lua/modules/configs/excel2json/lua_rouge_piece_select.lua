module("modules.configs.excel2json.lua_rouge_piece_select", package.seeall)

slot1 = {
	activeParam = 5,
	display = 11,
	triggerParam = 10,
	unlockParam = 3,
	id = 1,
	title = 6,
	content = 7,
	triggerType = 9,
	unlockType = 2,
	activeType = 4,
	talkDesc = 8
}
slot2 = {
	"id"
}
slot3 = {
	talkDesc = 3,
	title = 1,
	content = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
