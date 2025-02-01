module("modules.configs.excel2json.lua_story_role_audio", package.seeall)

slot1 = {
	bankName = 3,
	eventName_Overseas = 4,
	bankName_Overseas = 5,
	eventName = 2,
	id = 1
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
