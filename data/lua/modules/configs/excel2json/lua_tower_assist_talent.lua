module("modules.configs.excel2json.lua_tower_assist_talent", package.seeall)

slot1 = {
	bossId = 1,
	nodeId = 2,
	startNode = 4,
	nodeType = 12,
	extraRule = 9,
	nodeName = 13,
	nodeGroup = 8,
	nodeDesc = 14,
	isBigNode = 11,
	consume = 5,
	heroPassiveSkills = 7,
	position = 10,
	preNodeIds = 3,
	bossPassiveSkills = 6
}
slot2 = {
	"bossId",
	"nodeId"
}
slot3 = {
	nodeName = 1,
	nodeDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
