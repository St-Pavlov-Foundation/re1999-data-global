module("modules.configs.excel2json.lua_pat_face", package.seeall)

slot1 = {
	patFaceOrder = 5,
	patFaceStoryId = 4,
	id = 1,
	patFaceViewName = 3,
	patFaceActivityId = 2
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
