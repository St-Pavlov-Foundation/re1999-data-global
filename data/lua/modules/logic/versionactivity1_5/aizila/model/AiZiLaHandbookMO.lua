module("modules.logic.versionactivity1_5.aizila.model.AiZiLaHandbookMO", package.seeall)

local var_0_0 = pureTable("AiZiLaHandbookMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.itemId = arg_1_1 or 0
	arg_1_0._redPointKey = AiZiLaHelper.getRedKey(RedDotEnum.DotNode.V1a5AiZiLaHandbookNew, arg_1_0.itemId)
end

function var_0_0.getConfig(arg_2_0)
	if not arg_2_0._config then
		arg_2_0._config = AiZiLaConfig.instance:getItemCo(arg_2_0.itemId)
	end

	return arg_2_0._config
end

function var_0_0.getQuantity(arg_3_0)
	return AiZiLaModel.instance:getItemQuantity(arg_3_0.itemId)
end

function var_0_0.isHasRed(arg_4_0)
	if AiZiLaModel.instance:isCollectItemId(arg_4_0.itemId) and not AiZiLaHelper.isFinishRed(arg_4_0._redPointKey) then
		return true
	end

	return false
end

function var_0_0.finishRed(arg_5_0)
	AiZiLaHelper.finishRed(arg_5_0._redPointKey)
end

function var_0_0.getRedUid(arg_6_0)
	return arg_6_0.itemId
end

return var_0_0
