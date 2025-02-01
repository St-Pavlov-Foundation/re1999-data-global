module("modules.configs.excel2json.lua_magic_circle", package.seeall)

slot1 = {
	enemySkills = 10,
	enterTime = 15,
	selfSkills = 9,
	closeTime = 19,
	name = 2,
	enterAudio = 16,
	endSkills = 13,
	desc = 3,
	consumeType = 5,
	selfAttrs = 7,
	closeAudio = 21,
	enemyBuff = 12,
	enemyAttrs = 8,
	selfBuff = 11,
	closeEffect = 18,
	enterEffect = 14,
	posArr = 22,
	round = 4,
	loopEffect = 17,
	id = 1,
	consumeNum = 6,
	closeAniName = 20
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
