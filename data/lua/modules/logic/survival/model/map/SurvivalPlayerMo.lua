module("modules.logic.survival.model.map.SurvivalPlayerMo", package.seeall)

local var_0_0 = pureTable("SurvivalPlayerMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = 0
	arg_1_0.dir = arg_1_1.position.dir
	arg_1_0.pos = SurvivalHexNode.New(arg_1_1.position.hex.q, arg_1_1.position.hex.r)
	arg_1_0.explored = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.explored) do
		arg_1_0.explored[iter_1_0] = SurvivalHexNode.New(iter_1_1.q, iter_1_1.r)
	end
end

function var_0_0.getWorldPos(arg_2_0)
	return SurvivalHelper.instance:hexPointToWorldPoint(arg_2_0.pos.q, arg_2_0.pos.r)
end

function var_0_0.getResPath(arg_3_0)
	return (SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes))
end

return var_0_0
