module("modules.configs.excel2json.lua_fight_transition_act", package.seeall)

slot1 = {
	fromAct = 2,
	id = 1,
	endAct = 3,
	transitionAct = 4
}
slot2 = {
	"id",
	"fromAct",
	"endAct"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
