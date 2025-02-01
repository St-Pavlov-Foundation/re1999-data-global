module("modules.configs.excel2json.lua_room_character_anim", package.seeall)

slot1 = {
	animName = 2,
	upTime = 3,
	upDuration = 4,
	downDuration = 7,
	id = 1,
	downTime = 6,
	upDistance = 5,
	cameraState = 8
}
slot2 = {
	"id",
	"animName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
