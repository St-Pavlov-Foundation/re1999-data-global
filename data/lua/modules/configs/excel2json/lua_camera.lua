module("modules.configs.excel2json.lua_camera", package.seeall)

slot1 = {
	focusZ = 6,
	yaw = 2,
	distance = 4,
	id = 1,
	pitch = 3,
	fov = 5,
	yOffset = 7
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
