module("modules.configs.excel2json.lua_room_character_building_interact_camera", package.seeall)

slot1 = {
	nodesXYZ = 6,
	focusXYZ = 5,
	distance = 3,
	rotate = 4,
	id = 1,
	nextCameraParams = 7,
	angle = 2
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
