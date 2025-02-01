module("modules.configs.excel2json.lua_version_res_split", package.seeall)

slot1 = {
	path = 7,
	folderPath = 6,
	guide = 4,
	audio = 2,
	uiFolder = 8,
	story = 5,
	chapter = 3,
	id = 1,
	uiPath = 9
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
