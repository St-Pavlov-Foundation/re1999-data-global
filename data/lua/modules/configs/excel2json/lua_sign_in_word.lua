module("modules.configs.excel2json.lua_sign_in_word", package.seeall)

slot1 = {
	id = 1,
	signindate = 2,
	signinword = 3
}
slot2 = {
	"id"
}
slot3 = {
	signinword = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
