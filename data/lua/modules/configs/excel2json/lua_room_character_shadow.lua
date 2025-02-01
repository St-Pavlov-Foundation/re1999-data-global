module("modules.configs.excel2json.lua_room_character_shadow", package.seeall)

slot1 = {
	animName = 2,
	shadow = 3,
	skinId = 1
}
slot2 = {
	"skinId",
	"animName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
