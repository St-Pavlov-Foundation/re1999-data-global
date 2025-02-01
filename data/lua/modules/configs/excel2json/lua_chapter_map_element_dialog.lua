module("modules.configs.excel2json.lua_chapter_map_element_dialog", package.seeall)

slot1 = {
	param = 4,
	stepId = 2,
	audio = 5,
	type = 3,
	id = 1,
	speaker = 6,
	content = 7
}
slot2 = {
	"id",
	"stepId"
}
slot3 = {
	speaker = 1,
	content = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
