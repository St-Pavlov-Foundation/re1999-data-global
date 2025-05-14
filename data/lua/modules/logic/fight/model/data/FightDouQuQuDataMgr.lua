module("modules.logic.fight.model.data.FightDouQuQuDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightDouQuQuDataMgr")

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.cachePlayIndex(arg_2_0, arg_2_1)
	arg_2_0.playIndexTab = arg_2_1
	arg_2_0.maxIndex = 0

	for iter_2_0, iter_2_1 in pairs(arg_2_0.playIndexTab) do
		if iter_2_1 > arg_2_0.maxIndex then
			arg_2_0.maxIndex = iter_2_1
		end
	end
end

function var_0_0.cacheFightProto(arg_3_0, arg_3_1)
	arg_3_0.proto = arg_3_1
	arg_3_0.index = arg_3_1.index
	arg_3_0.round = arg_3_1.round
	arg_3_0.isFinish = arg_3_1.round == 0 and arg_3_1.startRound.isFinish or arg_3_1.fightRound.isFinish
end

function var_0_0.cacheGMProto(arg_4_0, arg_4_1)
	arg_4_0.gmProto = arg_4_1
end

return var_0_0
