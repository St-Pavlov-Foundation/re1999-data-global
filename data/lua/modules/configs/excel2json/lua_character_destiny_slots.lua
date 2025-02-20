module("modules.configs.excel2json.lua_character_destiny_slots", package.seeall)

slot1 = {
	node = 3,
	effect = 5,
	consume = 4,
	stage = 2,
	slotsId = 1
}
slot2 = {
	"slotsId",
	"stage",
	"node"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
