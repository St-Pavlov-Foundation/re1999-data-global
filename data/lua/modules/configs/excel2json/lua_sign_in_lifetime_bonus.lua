module("modules.configs.excel2json.lua_sign_in_lifetime_bonus", package.seeall)

slot1 = {
	logindaysid = 2,
	stagetitle = 3,
	bonus = 4,
	stageid = 1
}
slot2 = {
	"stageid"
}
slot3 = {
	stagetitle = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
