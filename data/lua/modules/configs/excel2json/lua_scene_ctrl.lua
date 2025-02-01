module("modules.configs.excel2json.lua_scene_ctrl", package.seeall)

slot1 = {
	resName = 1,
	param2 = 4,
	param1 = 3,
	param4 = 6,
	ctrlName = 2,
	param3 = 5
}
slot2 = {
	"resName",
	"ctrlName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
