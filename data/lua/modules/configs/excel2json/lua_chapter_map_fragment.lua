module("modules.configs.excel2json.lua_chapter_map_fragment", package.seeall)

slot1 = {
	toastId = 6,
	res = 3,
	type = 4,
	id = 1,
	title = 2,
	content = 5
}
slot2 = {
	"id"
}
slot3 = {
	content = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
