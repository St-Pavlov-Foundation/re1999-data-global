module("modules.logic.survival.model.shelter.SurvivalShelterDecreePolicyMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterDecreePolicyMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.co = SurvivalConfig.instance:getDecreeCo(arg_1_1)
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.needVoteNum = arg_2_1.needVoteNum
	arg_2_0.currVoteNum = arg_2_1.currVoteNum
	arg_2_0.effective = arg_2_1.effective
end

function var_0_0.isFinish(arg_3_0)
	if not arg_3_0.currVoteNum or not arg_3_0.needVoteNum then
		return false
	end

	return arg_3_0.currVoteNum >= arg_3_0.needVoteNum
end

return var_0_0
