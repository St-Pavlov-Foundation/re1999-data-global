module("modules.configs.excel2json.lua_rogue_event_fight", package.seeall)

slot1 = {
	heartChange5 = 8,
	heartChange4 = 7,
	attrChange1 = 9,
	type = 3,
	oldtemplate = 14,
	attrChange2 = 10,
	episode = 2,
	attrChange3 = 11,
	attrChange5 = 13,
	attrChange4 = 12,
	newtemplate = 15,
	heartChange1 = 4,
	id = 1,
	heartChange2 = 5,
	isChangeScene = 16,
	heartChange3 = 6
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
