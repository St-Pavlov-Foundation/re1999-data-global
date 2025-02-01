module("modules.configs.excel2json.lua_room_audio_extend", package.seeall)

slot1 = {
	audioId = 2,
	rtpcValue = 6,
	rtpc = 5,
	switchGroup = 3,
	id = 1,
	switchState = 4
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
