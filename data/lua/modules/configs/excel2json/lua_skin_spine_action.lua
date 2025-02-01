module("modules.configs.excel2json.lua_skin_spine_action", package.seeall)

slot1 = {
	audioId = 6,
	effect = 3,
	effectRemoveTime = 5,
	skinId = 1,
	effectHangPoint = 4,
	dieAnim = 7,
	actionName = 2
}
slot2 = {
	"skinId",
	"actionName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
