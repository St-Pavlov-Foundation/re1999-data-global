module("modules.logic.rouge.map.model.rpcmo.RougeMapInfoMO", package.seeall)

local var_0_0 = pureTable("RougeMapInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.mapType = arg_1_1.mapType
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.middleLayerId = arg_1_1.middleLayerId
	arg_1_0.curStage = arg_1_1.curStage
	arg_1_0.curNode = arg_1_1.curNode
	arg_1_0.nodeInfo = GameUtil.rpcInfosToList(arg_1_1.nodeInfo, RougeNodeInfoMO)
	arg_1_0.skillInfo = GameUtil.rpcInfosToList(arg_1_1.mapSkill, RougeMapSkillMO)
end

return var_0_0
