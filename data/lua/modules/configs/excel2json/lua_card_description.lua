module("modules.configs.excel2json.lua_card_description", package.seeall)

slot1 = {
	card2 = 4,
	card1 = 2,
	cardname_en = 5,
	cardname = 6,
	id = 1,
	carddescription2 = 8,
	carddescription1 = 7,
	attribute = 3
}
slot2 = {
	"id"
}
slot3 = {
	carddescription1 = 2,
	carddescription2 = 3,
	cardname = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
