module("modules.configs.excel2json.lua_playercard_theme", package.seeall)

slot1 = {
	itemId = 5,
	name = 2,
	id = 1,
	cardRes = 3,
	unlockCondition = 4
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
