module("modules.configs.excel2json.lua_activity123_story", package.seeall)

slot1 = {
	id = 1,
	picture = 5,
	subTitle = 6,
	storyId = 2,
	condition = 9,
	title = 3,
	content = 8,
	titleEn = 4,
	subContent = 7
}
slot2 = {
	"id",
	"storyId"
}
slot3 = {
	subTitle = 3,
	titleEn = 2,
	subContent = 4,
	title = 1,
	content = 5
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
