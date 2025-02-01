module("modules.configs.excel2json.lua_lucky_bag_heroes", package.seeall)

slot1 = {
	heroChoices = 3,
	name = 4,
	nameEn = 5,
	sceneIcon = 7,
	icon = 6,
	bagId = 2,
	poolId = 1
}
slot2 = {
	"poolId",
	"bagId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
