module("modules.configs.excel2json.lua_tower_assist_boss", package.seeall)

slot1 = {
	bossId = 1,
	passiveSkills = 12,
	heartVariantId = 9,
	skinId = 5,
	name = 3,
	gender = 6,
	career = 4,
	passiveSkillName = 13,
	dmgType = 7,
	tag = 8,
	coldTime = 10,
	resMaxVal = 15,
	bossShadowPic = 17,
	resInitVal = 14,
	towerId = 2,
	activeSkills = 11,
	bossPic = 16
}
slot2 = {
	"bossId"
}
slot3 = {
	tag = 2,
	name = 1,
	passiveSkillName = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
