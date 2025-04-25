module("modules.configs.excel2json.lua_help_page_tab", package.seeall)

slot1 = {
	parentId = 2,
	title_en = 5,
	sortIdx = 3,
	showType = 6,
	id = 1,
	title = 4,
	helpId = 7
}
slot2 = {
	"id"
}
slot3 = {
	title_en = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
