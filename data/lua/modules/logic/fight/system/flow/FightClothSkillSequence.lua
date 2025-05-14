module("modules.logic.fight.system.flow.FightClothSkillSequence", package.seeall)

local var_0_0 = class("FightClothSkillSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0, arg_1_1)
	var_0_0.super.buildFlow(arg_1_0)

	arg_1_0.roundMO = arg_1_1

	arg_1_0:buildRoundFlows()
end

function var_0_0.buildRoundFlows(arg_2_0)
	arg_2_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.StartPlayClothSkill)
	end))

	local var_2_0 = FightStepBuilder.buildStepWorkList(arg_2_0.roundMO and arg_2_0.roundMO.fightStepMOs)

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			arg_2_0:addWork(iter_2_1)
		end
	end

	arg_2_0:addWork(FunctionWork.New(function()
		FightDataMgr.instance:afterPlayRoundProto(FightDataModel.instance.cacheRoundProto)
	end))
	arg_2_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterPlayClothSkill)
	end))
end

return var_0_0
