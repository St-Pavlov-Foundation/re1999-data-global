module("modules.configs.excel2json.lua_activity_dungeon", package.seeall)

slot1 = {
	hardChapterId = 5,
	story3ChapterId = 4,
	id = 1,
	story1ChapterId = 2,
	story2ChapterId = 3
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
