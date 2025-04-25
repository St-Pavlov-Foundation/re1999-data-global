module("modules.configs.excel2json.lua_activity101_lifetime_bonus", package.seeall)

slot1 = {
	stagetitle = 4,
	bonus = 5,
	stagename = 3,
	logindaysid = 2,
	stagepriceid = 1
}
slot2 = {
	"stagepriceid"
}
slot3 = {
	stagename = 1,
	stagetitle = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
