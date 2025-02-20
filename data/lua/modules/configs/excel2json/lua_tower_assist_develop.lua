module("modules.configs.excel2json.lua_tower_assist_develop", package.seeall)

slot1 = {
	bossId = 1,
	passiveSkills = 5,
	talentPoint = 4,
	attribute = 3,
	extraRule = 6,
	level = 2
}
slot2 = {
	"bossId",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
