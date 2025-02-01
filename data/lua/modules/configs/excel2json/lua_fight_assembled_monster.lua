module("modules.configs.excel2json.lua_fight_assembled_monster", package.seeall)

slot1 = {
	clickIndex = 6,
	virtualStance = 3,
	part = 2,
	hpPos = 8,
	id = 1,
	virtualSpineSize = 5,
	selectPos = 7,
	virtualSpinePos = 4
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
