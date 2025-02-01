module("modules.configs.excel2json.lua_cg", package.seeall)

slot1 = {
	preCgId = 9,
	name = 4,
	nameEn = 5,
	storyChapterId = 3,
	desc = 6,
	image = 8,
	episodeId = 7,
	id = 1,
	order = 2
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
