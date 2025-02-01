module("modules.configs.excel2json.lua_weekwalk_question", package.seeall)

slot1 = {
	text = 2,
	select3 = 5,
	select2 = 4,
	id = 1,
	select1 = 3
}
slot2 = {
	"id"
}
slot3 = {
	text = 1,
	select1 = 2,
	select3 = 4,
	select2 = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
