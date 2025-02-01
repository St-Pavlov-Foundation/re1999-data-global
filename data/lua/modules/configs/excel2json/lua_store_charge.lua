module("modules.configs.excel2json.lua_store_charge", package.seeall)

slot1 = {
	id = 1,
	packageName = 2,
	appStoreProductID = 3
}
slot2 = {
	"id",
	"packageName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
