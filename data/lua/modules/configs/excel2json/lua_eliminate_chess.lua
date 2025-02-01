module("modules.configs.excel2json.lua_eliminate_chess", package.seeall)

slot1 = {
	cost = 5,
	name = 2,
	defaultPower = 4,
	resPic = 6,
	rare = 3,
	chessId = 1,
	skillId = 8,
	resModel = 7,
	defaultUnlock = 9
}
slot2 = {
	"chessId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
