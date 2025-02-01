module("modules.configs.excel2json.lua_loading_text", package.seeall)

slot1 = {
	unlocklevel = 2,
	titleen = 5,
	content = 6,
	id = 1,
	title = 4,
	weight = 3,
	scenes = 7
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
