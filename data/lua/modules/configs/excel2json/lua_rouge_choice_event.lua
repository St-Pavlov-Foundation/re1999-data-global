module("modules.configs.excel2json.lua_rouge_choice_event", package.seeall)

slot1 = {
	version = 3,
	image = 6,
	type = 2,
	id = 1,
	title = 4,
	desc = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
