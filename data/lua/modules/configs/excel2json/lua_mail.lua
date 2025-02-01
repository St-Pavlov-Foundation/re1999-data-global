module("modules.configs.excel2json.lua_mail", package.seeall)

slot1 = {
	jump = 13,
	needShowToast = 7,
	sender = 3,
	type = 2,
	attachment = 6,
	title = 4,
	addressee = 8,
	copy = 9,
	specialTag = 11,
	content = 5,
	image = 14,
	jumpTitle = 12,
	id = 1,
	icon = 10,
	senderType = 15
}
slot2 = {
	"id"
}
slot3 = {
	content = 3,
	title = 2,
	jumpTitle = 6,
	copy = 5,
	sender = 1,
	addressee = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
