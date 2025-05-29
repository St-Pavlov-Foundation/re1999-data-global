module("modules.logic.rouge.dlc.103.model.RougeLayerChoiceInfoMO", package.seeall)

local var_0_0 = pureTable("RougeLayerChoiceInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.mapRuleId = arg_1_1.mapRuleId
	arg_1_0.mapRuleCo = RougeDLCConfig103.instance:getMapRuleConfig(arg_1_0.mapRuleId)
	arg_1_0.curLayerCollection = {}

	tabletool.addValues(arg_1_0.curLayerCollection, arg_1_1.curLayerCollection)

	arg_1_0.mapRuleCanFreshNum = arg_1_1.mapRuleCanFreshNum
end

function var_0_0.getMapRuleCo(arg_2_0)
	return arg_2_0.mapRuleCo
end

function var_0_0.getMapRuleType(arg_3_0)
	local var_3_0 = arg_3_0:getMapRuleCo()

	return var_3_0 and var_3_0.type
end

function var_0_0.getCurLayerCollection(arg_4_0)
	return arg_4_0.curLayerCollection
end

function var_0_0.getMapRuleCanFreshNum(arg_5_0)
	return arg_5_0.mapRuleCanFreshNum
end

return var_0_0
