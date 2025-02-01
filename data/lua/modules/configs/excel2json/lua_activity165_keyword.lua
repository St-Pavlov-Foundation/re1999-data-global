module("modules.configs.excel2json.lua_activity165_keyword", package.seeall)

slot1 = {
	keywordId = 1,
	text = 3,
	pic = 4,
	belongStoryId = 2
}
slot2 = {
	"keywordId"
}
slot3 = {
	text = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
