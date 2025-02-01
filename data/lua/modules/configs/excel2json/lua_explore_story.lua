module("modules.configs.excel2json.lua_explore_story", package.seeall)

slot1 = {
	type = 6,
	res = 5,
	chapterId = 1,
	id = 2,
	title = 3,
	content = 7,
	desc = 4
}
slot2 = {
	"chapterId",
	"id"
}
slot3 = {
	title = 1,
	content = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
