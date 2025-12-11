module("modules.logic.fight.system.work.FightWorkPlayCloth", package.seeall)

local var_0_0 = class("FightWorkPlayCloth", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	arg_1_0.roundData = FightDataHelper.roundMgr:getRoundData()

	local var_1_0 = arg_1_0:com_registFlowSequence()

	var_1_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.StartPlayClothSkill)
	end))

	local var_1_1 = FightStepBuilder.buildStepWorkList(arg_1_0.roundData and arg_1_0.roundData.fightStep)

	if var_1_1 then
		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			var_1_0:addWork(iter_1_1)
		end
	end

	var_1_0:addWork(FunctionWork.New(function()
		local var_3_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_3_0)
	end))
	var_1_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterPlayClothSkill)
	end))
	var_1_0:registFinishCallback(arg_1_0.onClothFinish, arg_1_0)
	arg_1_0:playWorkAndDone(var_1_0, {})
end

function var_0_0.onClothFinish(arg_5_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.ClothSkill)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillRoundSequenceFinish)
end

return var_0_0
