module("modules.configs.excel2json.lua_player_bg", package.seeall)

slot1 = {
	bg = 6,
	name = 2,
	item = 4,
	chatbg = 8,
	bgEffect = 7,
	desc = 3,
	infobg = 9,
	id = 1,
	lockdesc = 5
}
slot2 = {
	"id"
}
slot3 = {
	lockdesc = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
