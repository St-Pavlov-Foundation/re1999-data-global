module("modules.configs.excel2json.lua_monster_guide_focus", package.seeall)

slot1 = {
	param = 3,
	invokeType = 2,
	completeWithGroup = 5,
	isActivityVersion = 7,
	id = 1,
	icon = 6,
	monster = 4,
	des = 8
}
slot2 = {
	"id",
	"invokeType",
	"param",
	"monster"
}
slot3 = {
	des = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
