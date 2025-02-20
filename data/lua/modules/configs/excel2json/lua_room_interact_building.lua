module("modules.configs.excel2json.lua_room_interact_building", package.seeall)

slot1 = {
	buildingId = 1,
	heroCount = 2,
	cameraId = 8,
	heroAnimStr = 6,
	interactType = 4,
	intervalTime = 3,
	buildingAnim = 7,
	showTime = 5
}
slot2 = {
	"buildingId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
