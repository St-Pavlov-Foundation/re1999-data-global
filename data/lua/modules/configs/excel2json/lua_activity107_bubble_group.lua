module("modules.configs.excel2json.lua_activity107_bubble_group", package.seeall)

slot1 = {
	groupId = 1,
	unlockCondition = 4,
	actId = 2,
	resource = 3
}
slot2 = {
	"groupId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
