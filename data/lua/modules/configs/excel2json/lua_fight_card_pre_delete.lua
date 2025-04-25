module("modules.configs.excel2json.lua_fight_card_pre_delete", package.seeall)

slot1 = {
	skillID = 1,
	left = 2,
	right = 3
}
slot2 = {
	"skillID"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
