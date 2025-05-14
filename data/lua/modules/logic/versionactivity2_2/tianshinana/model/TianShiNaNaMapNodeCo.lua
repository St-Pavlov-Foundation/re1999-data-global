module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapNodeCo", package.seeall)

local var_0_0 = pureTable("TianShiNaNaMapNodeCo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.x = arg_1_1[1]
	arg_1_0.y = arg_1_1[2]
	arg_1_0.nodeType = arg_1_1[3]
	arg_1_0.collapseRound = arg_1_1[4]
	arg_1_0.nodePath = arg_1_1[5]
	arg_1_0.walkable = arg_1_1[6]
end

function var_0_0.isCollapse(arg_2_0)
	if not arg_2_0.collapseRound or arg_2_0.collapseRound == 0 or arg_2_0.collapseRound > TianShiNaNaModel.instance.nowRound then
		return false
	end

	return true
end

return var_0_0
