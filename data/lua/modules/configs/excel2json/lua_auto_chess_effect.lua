module("modules.configs.excel2json.lua_auto_chess_effect", package.seeall)

slot1 = {
	tag = 2,
	subtag = 3,
	nameDown = 5,
	type = 6,
	target = 9,
	offset = 11,
	nameUp = 4,
	duration = 12,
	loop = 8,
	playertype = 7,
	soundId = 13,
	id = 1,
	position = 10
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
