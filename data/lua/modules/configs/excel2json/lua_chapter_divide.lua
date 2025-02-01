module("modules.configs.excel2json.lua_chapter_divide", package.seeall)

slot1 = {
	resPageClosed = 5,
	name = 2,
	nameEn = 3,
	resPage = 4,
	chapterId = 6,
	sectionId = 1
}
slot2 = {
	"sectionId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
