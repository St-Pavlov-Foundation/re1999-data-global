module("modules.configs.excel2json.lua_turnback_sp_h5", package.seeall)

slot1 = {
	type2BindCount = 2,
	asNewUserTime = 3,
	id = 1
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
