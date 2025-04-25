module("modules.configs.excel2json.lua_version_res_split", package.seeall)

slot1 = {
	path = 8,
	guide = 4,
	videoPath = 7,
	audio = 2,
	folderPath = 6,
	uiFolder = 9,
	story = 5,
	chapter = 3,
	id = 1,
	uiPath = 10
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
