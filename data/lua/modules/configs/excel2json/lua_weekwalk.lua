module("modules.configs.excel2json.lua_weekwalk", package.seeall)

slot1 = {
	notCdHeroCount = 5,
	resIdRear = 11,
	preId = 3,
	type = 4,
	fightIdFront = 8,
	sceneId = 6,
	issueId = 7,
	resIdFront = 9,
	id = 1,
	fightIdRear = 10,
	layer = 2
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
