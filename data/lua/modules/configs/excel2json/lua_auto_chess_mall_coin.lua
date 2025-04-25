module("modules.configs.excel2json.lua_auto_chess_mall_coin", package.seeall)

slot1 = {
	round = 1,
	coinNum = 2
}
slot2 = {
	"round"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
