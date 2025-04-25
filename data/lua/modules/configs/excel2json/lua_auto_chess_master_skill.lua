module("modules.configs.excel2json.lua_auto_chess_master_skill", package.seeall)

slot1 = {
	cost = 2,
	abilities = 6,
	type = 3,
	activeChessSkill = 5,
	passiveChessSkills = 4,
	skillIndex = 9,
	skillaction = 7,
	useeffect = 8,
	id = 1
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
