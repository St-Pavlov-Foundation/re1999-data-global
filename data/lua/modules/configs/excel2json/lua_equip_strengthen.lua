module("modules.configs.excel2json.lua_equip_strengthen", package.seeall)

slot1 = {
	strengthType = 1,
	def = 4,
	hp = 2,
	atk = 3,
	mdef = 5
}
slot2 = {
	"strengthType"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
