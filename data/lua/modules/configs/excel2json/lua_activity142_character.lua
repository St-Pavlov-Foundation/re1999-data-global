module("modules.configs.excel2json.lua_activity142_character", package.seeall)

slot1 = {
	activityId = 1,
	canTriggerPedal = 3,
	canUseFireball = 5,
	canBreakTile = 6,
	characterType = 2,
	canLightBrazier = 4
}
slot2 = {
	"activityId",
	"characterType"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
