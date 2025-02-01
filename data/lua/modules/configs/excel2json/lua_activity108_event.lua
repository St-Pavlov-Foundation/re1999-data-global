module("modules.configs.excel2json.lua_activity108_event", package.seeall)

slot1 = {
	pos = 9,
	conditionParam = 4,
	type = 5,
	group = 6,
	title = 8,
	condition = 3,
	episodeId = 2,
	interactParam = 7,
	model = 10,
	id = 1,
	modelPos = 11
}
slot2 = {
	"id"
}
slot3 = {
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
