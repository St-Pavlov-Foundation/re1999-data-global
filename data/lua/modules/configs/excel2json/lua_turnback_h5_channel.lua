module("modules.configs.excel2json.lua_turnback_h5_channel", package.seeall)

slot1 = {
	id = 1,
	channelId = 2,
	url = 3
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
