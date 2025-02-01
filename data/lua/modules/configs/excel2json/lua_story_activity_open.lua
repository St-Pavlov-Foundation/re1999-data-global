module("modules.configs.excel2json.lua_story_activity_open", package.seeall)

slot1 = {
	part = 2,
	chapter = 1,
	labelRes = 5,
	titleEn = 4,
	title = 3,
	storyBg = 6
}
slot2 = {
	"chapter",
	"part"
}
slot3 = {
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
