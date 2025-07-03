module("modules.logic.fight.system.flow.FightClothSkillSequence", package.seeall)

local var_0_0 = class("FightClothSkillSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0, arg_1_1)
	var_0_0.super.buildFlow(arg_1_0)

	arg_1_0.roundData = arg_1_1

	arg_1_0:buildRoundFlows()
end

function var_0_0.buildRoundFlows(arg_2_0)
	arg_2_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.StartPlayClothSkill)
	end))

	local var_2_0 = FightStepBuilder.buildStepWorkList(arg_2_0.roundData and arg_2_0.roundData.fightStep)

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			arg_2_0:addWork(iter_2_1)
		end
	end

	arg_2_0:addWork(FunctionWork.New(function()
		local var_4_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_4_0)
	end))
	arg_2_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterPlayClothSkill)
	end))
end

return var_0_0
