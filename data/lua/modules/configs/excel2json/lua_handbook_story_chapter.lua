module("modules.configs.excel2json.lua_handbook_story_chapter", package.seeall)

slot1 = {
	nameEn = 4,
	name = 3,
	year = 5,
	id = 1,
	order = 2
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
