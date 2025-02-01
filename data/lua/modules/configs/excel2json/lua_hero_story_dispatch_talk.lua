module("modules.configs.excel2json.lua_hero_story_dispatch_talk", package.seeall)

slot1 = {
	speaker = 5,
	id = 1,
	heroid = 6,
	type = 2,
	color = 4,
	content = 3
}
slot2 = {
	"id"
}
slot3 = {
	content = 1,
	speaker = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
